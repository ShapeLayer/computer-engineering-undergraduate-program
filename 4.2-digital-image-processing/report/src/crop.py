import argparse
import sys
import os
from PIL import Image

def parse_point(point_str: str) -> tuple:
    """
    'x,y' 형식의 문자열을 (x, y) 튜플로 파싱합니다.
    유효하지 않은 형식일 경우 ValueError를 발생시킵니다.
    """
    try:
        x_str, y_str = point_str.split(',')
        x = int(x_str.strip())
        y = int(y_str.strip())
        return (x, y)
    except ValueError:
        raise ValueError(f"유효하지 않은 좌표 형식입니다: '{point_str}'. 'x,y' 형식(x, y는 정수)을 기대합니다.")

def determine_format_from_extension(file_path: str) -> str | None:
    if not file_path:
        return None
    ext = os.path.splitext(file_path)[1].lower()
    if not ext:
        return None
    ext = ext.lstrip('.')
    extension_map = {
        'jpg': 'JPEG',
        'jpeg': 'JPEG',
        'tif': 'TIFF',
        'tiff': 'TIFF',
        'png': 'PNG',
        'webp': 'WEBP'
    }
    return extension_map.get(ext, ext.upper())


def prepare_image_for_format(img: Image.Image, output_format: str | None) -> Image.Image:
    if not output_format or output_format == 'TIFF':
        return img

    if output_format == 'JPEG':
        if img.mode not in {'RGB', 'L'}:
            return img.convert('RGB')
        return img

    if output_format in {'PNG', 'WEBP'} and img.mode == 'F':
        return img.convert('RGB')

    return img


def crop_and_save_image(input_image_path: str, output_image_path: str, p1: tuple, p2: tuple, quality: int = 90):
    """Crop a rectangular region from any supported image and save it using the output file's format."""
    try:
        # 1. 이미지 열기
        img = Image.open(input_image_path)

        # 2. 자를 영역 (bounding box) 정의
        # Pillow의 crop() 메서드는 (left, upper, right, lower) 튜플을 인자로 받습니다.
        # p1과 p2의 순서에 관계없이 올바른 bounding box를 만들기 위해 min/max를 사용합니다.
        x1, y1 = p1
        x2, y2 = p2

        left = min(x1, x2)
        upper = min(y1, y2)
        right = max(x1, x2)
        lower = max(y1, y2)

        img_width, img_height = img.size
        
        # 자르기 영역을 이미지 경계 내로 조정합니다.
        # 사용자가 이미지 밖의 영역을 지정했더라도, 실제 자르기는 이미지 내부에서만 이루어집니다.
        clipped_left = max(0, left)
        clipped_upper = max(0, upper)
        clipped_right = min(img_width, right)
        clipped_lower = min(img_height, lower)

        # 조정된 자르기 영역이 유효한지 확인 (너비나 높이가 0 이하가 아닌지)
        if clipped_left >= clipped_right or clipped_upper >= clipped_lower:
            raise ValueError(
                f"유효하지 않거나 비어있는 자르기 영역입니다. "
                f"요청된 영역: ({left},{upper},{right},{lower}), 이미지 크기: ({img_width},{img_height}). "
                f"조정된 유효 영역: ({clipped_left},{clipped_upper},{clipped_right},{clipped_lower}). "
                f"너비 또는 높이가 0 이하입니다."
            )

        crop_box = (clipped_left, clipped_upper, clipped_right, clipped_lower)
        
        # 3. 이미지 자르기
        cropped_img = img.crop(crop_box)
        output_format = determine_format_from_extension(output_image_path)
        cropped_img = prepare_image_for_format(cropped_img, output_format)
        
        save_kwargs = {}
        if output_format:
            save_kwargs['format'] = output_format
        if output_format == 'JPEG':
            save_kwargs.update(quality=quality, optimize=True)
        elif output_format in {'PNG', 'WEBP', 'TIFF'}:
            save_kwargs['optimize'] = True

        cropped_img.save(output_image_path, **save_kwargs)

    except FileNotFoundError:
        # 파일이 없을 경우, FileNotFoundError를 다시 발생시켜 main 함수에서 처리
        raise FileNotFoundError(f"입력 이미지 파일을 찾을 수 없습니다: '{input_image_path}'")
    except ValueError as ve:
        # 좌표 파싱 오류나 유효하지 않은 자르기 영역 오류 등
        raise ValueError(f"이미지 처리 오류: {ve}")
    except Exception as e:
        # Pillow 내부 오류 등 예상치 못한 모든 오류
        raise Exception(f"이미지 처리 중 예상치 못한 오류가 발생했습니다: {e}")

def main():
    # ArgumentParser 설정
    parser = argparse.ArgumentParser(
        description="""지정된 두 점으로 정의된 사각형 영역을 잘라서 다양한 이미지 포맷으로 저장합니다.

예시:
    python app.py -p1 200,200 -p2 400,400 input-image.png cropped-image.png
    python app.py -p1 100,100 -p2 500,500 -q 85 original.jpg cropped.jpg
""",
        formatter_class=argparse.RawTextHelpFormatter # 다중 라인 설명을 위해 필요
    )

    parser.add_argument(
        '-p1',
        required=True,
        help='자를 영역의 첫 번째 점 (x1,y1). 예시: "200,200"'
    )
    parser.add_argument(
        '-p2',
        required=True,
        help='자를 영역의 두 번째 점 (x2,y2). 예시: "400,400"'
    )
    parser.add_argument(
        'input_image_path',
        help='원본 이미지 파일의 경로.'
    )
    parser.add_argument(
        'output_image_path',
        help='잘라낸 이미지를 저장할 경로.'
    )
    parser.add_argument(
        '-q', '--quality',
        type=int,
        default=90,
        choices=range(0, 101), # 품질은 0부터 100까지
        metavar='[0-100]',
        help='JPEG 저장 품질 (0-100). 기본값은 90.'
    )

    args = parser.parse_args()

    try:
        # 명령줄 인자 파싱 및 유효성 검사
        p1 = parse_point(args.p1)
        p2 = parse_point(args.p2)

        # 출력 파일의 부모 디렉토리가 없으면 생성
        output_dir = os.path.dirname(args.output_image_path)
        if output_dir and not os.path.exists(output_dir):
            os.makedirs(output_dir)

        # 이미지 자르기 및 저장 함수 호출
        crop_and_save_image(
            args.input_image_path,
            args.output_image_path,
            p1,
            p2,
            quality=args.quality
        )
        print(f"이미지가 성공적으로 잘려 '{args.output_image_path}'에 저장되었습니다.")

    except ValueError as ve:
        print(f"오류: {ve}", file=sys.stderr)
        sys.exit(1)
    except FileNotFoundError as fnfe:
        print(f"오류: {fnfe}", file=sys.stderr)
        sys.exit(1)
    except Exception as e:
        print(f"예상치 못한 오류 발생: {e}", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    main()
