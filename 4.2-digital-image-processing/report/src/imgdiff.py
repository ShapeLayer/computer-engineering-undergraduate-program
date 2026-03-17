import cv2
import numpy as np

class SpotDiffSolver:
    def __init__(self):
        # 특징점 검출기 (정밀 정렬용)
        self.orb = cv2.ORB_create(5000)
        self.bf = cv2.BFMatcher(cv2.NORM_HAMMING, crossCheck=True)

    def process(self, image_paths):
        """
        image_paths: 리스트 형태. 
        - [path] 1개일 때: 가로/세로 비율에 따라 자동 분할
        - [path1, path2] 2개일 때: 두 파일을 각각 로드
        """
        is_vertical_split = False
        
        if len(image_paths) == 1:
            full_img = cv2.imread(image_paths[0])
            if full_img is None: return
            
            h, w, _ = full_img.shape
            
            # 가로가 더 길면 가로 분할, 세로가 더 길면 세로 분할로 판단
            if w > h:
                print("모드: 단일 이미지 [가로] 분할 처리")
                half_w = w // 2
                img_ref = full_img[:, :half_w]
                img_target = full_img[:, half_w:]
                is_vertical_split = False
            else:
                print("모드: 단일 이미지 [세로] 분할 처리")
                half_h = h // 2
                img_ref = full_img[:half_h, :]
                img_target = full_img[half_h:, :]
                is_vertical_split = True
        else:
            print("모드: 두 개의 별도 이미지 비교 처리")
            img_ref = cv2.imread(image_paths[0])
            img_target = cv2.imread(image_paths[1])
            if img_ref is None or img_target is None: return
            is_vertical_split = False

        # 1. 정밀 정렬 (Alignment)
        # img_target을 img_ref의 좌표계와 각도에 맞춤
        aligned_target, _ = self.align_images(img_ref, img_target)

        # 2. 차이점 검출
        diff_mask = self.get_difference_mask(img_ref, aligned_target)

        # 3. 결과 시각화
        result = self.draw_results(img_ref, aligned_target, diff_mask, is_vertical_split)
        
        cv2.imshow('Spot the Difference - Result', result)
        cv2.waitKey(0)
        cv2.destroyAllWindows()

    def align_images(self, base_img, target_img):
        """특징점 매칭을 통해 이미지를 정렬 (기울어짐, 크기 차이 보정)"""
        gray1 = cv2.cvtColor(base_img, cv2.COLOR_BGR2GRAY)
        gray2 = cv2.cvtColor(target_img, cv2.COLOR_BGR2GRAY)

        kp1, des1 = self.orb.detectAndCompute(gray1, None)
        kp2, des2 = self.orb.detectAndCompute(gray2, None)

        if des1 is None or des2 is None:
            return target_img, None

        matches = self.bf.match(des1, des2)
        matches = sorted(matches, key=lambda x: x.distance)

        # 상위 10%의 매칭점만 사용
        good_matches = matches[:int(len(matches) * 0.1)]
        src_pts = np.float32([kp1[m.queryIdx].pt for m in good_matches]).reshape(-1, 1, 2)
        dst_pts = np.float32([kp2[m.trainIdx].pt for m in good_matches]).reshape(-1, 1, 2)

        # 투영 변환 행렬 계산
        matrix, mask = cv2.findHomography(dst_pts, src_pts, cv2.RANSAC, 5.0)
        
        h, w, _ = base_img.shape
        aligned_img = cv2.warpPerspective(target_img, matrix, (w, h))
        
        return aligned_img, mask

    def get_difference_mask(self, img1, img2):
        """두 이미지의 픽셀 차이를 계산하여 마스크 생성"""
        gray1 = cv2.cvtColor(img1, cv2.COLOR_BGR2GRAY)
        gray2 = cv2.cvtColor(img2, cv2.COLOR_BGR2GRAY)

        # 절대 차이 계산 및 블러링으로 노이즈 제거
        diff = cv2.absdiff(gray1, gray2)
        diff_blur = cv2.GaussianBlur(diff, (13, 13), 0)
        
        # 임계값 처리 (값이 낮을수록 예민하게 반응)
        _, thresh = cv2.threshold(diff_blur, 40, 255, cv2.THRESH_BINARY)
        
        # 형태학적 연산으로 흩어진 점들을 하나의 영역으로 뭉침
        kernel = np.ones((7, 7), np.uint8)
        thresh = cv2.morphologyEx(thresh, cv2.MORPH_CLOSE, kernel)
        thresh = cv2.dilate(thresh, kernel, iterations=2)
        
        return thresh

    def draw_results(self, img_ref, img_target, mask, is_vertical):
        """검출된 차이점을 사각형으로 표시하고 결과 이미지 결합"""
        contours, _ = cv2.findContours(mask, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
        
        res_ref = img_ref.copy()
        res_target = img_target.copy()

        for cnt in contours:
            if cv2.contourArea(cnt) > 100: # 너무 작은 노이즈 제거
                x, y, w, h = cv2.boundingRect(cnt)
                cv2.rectangle(res_ref, (x, y), (x + w, y + h), (0, 0, 255), 3)
                cv2.rectangle(res_target, (x, y), (x + w, y + h), (0, 0, 255), 3)

        # 원본 배치에 따라 가로 또는 세로로 합치기
        if is_vertical:
            combined = np.vstack((res_ref, res_target))
        else:
            combined = np.hstack((res_ref, res_target))
        
        # 화면 출력을 위해 리사이즈 (모니터 해상도 고려)
        max_h, max_w = 900, 1200
        h, w = combined.shape[:2]
        scale = min(max_h/h, max_w/w)
        
        if scale < 1.0:
            combined = cv2.resize(combined, None, fx=scale, fy=scale)
            
        return combined

# --- 실행 예시 ---
solver = SpotDiffSolver()
solver.process(['1201-i.webp'])
solver.process(['1208-i.webp'])
solver.process(['1210-i.webp'])

# 1. 세로로 나열된 한 장의 사진인 경우
# solver.process(['vertical_puzzle.jpg'])

# 2. 가로로 나열된 한 장의 사진인 경우
# solver.process(['horizontal_puzzle.jpg'])

# 3. 두 개의 개별 파일인 경우
# solver.process(['img1.jpg', 'img2.jpg'])
