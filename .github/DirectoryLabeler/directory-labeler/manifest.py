import tomllib

output_template = '''# {name}
| 항목 | 내용 |
| :-: | :-: |
| 과목명 | {name} |
| 과목 코드 | {code} |
| 교수 | {prof} |
| 대상 학기 | {course} |
| 수업 학기 | {opened_at} |
| 개설 학과 | {dept} |
'''

class Manifest:
    output_template = output_template
    def f_course(course: list[int]) -> str:
        if len(course) < 1:
            return ''
        if len(course) < 2:
            return f'{course[0]}학년'
        return f'{course[0]}학년 {course[1]}학기'

    def f_opened_at(opened_at: list[int]) -> str:
        '''
        1: 1학기
        2: 2학기
        3: 3학기
        11: 여름학기
        12: 겨울학기
        '''
        if len(opened_at) < 1:
            return ''
        if len(opened_at) < 2:
            return f'{opened_at[0]}년'
        y, s = opened_at
        if s == 11:
            s = '여름'
        if s == 12:
            s = '겨울'
        return f'{y}년 {s}학기'

    def __init__(self, content: str):
        parsed = tomllib.loads(content)
        self.name = parsed['name'] if 'name' in parsed else None
        self.code = parsed['code'] if 'code' in parsed else None
        self.course = parsed['course'] if 'course' in parsed else None
        self.opened_at = parsed['opened_at'] if 'opened_at' in parsed else None
        self.prof = parsed['prof'] if 'prof' in parsed else None
        self.dept = parsed['dept'] if 'dept' in parsed else None

    def render(self):
        return Manifest.output_template.format(
            name=self.name,
            code=self.code,
            course=self.course,
            opened_at=Manifest.f_opened_at(self.opened_at),
            prof=self.prof,
            dept=self.dept
        )
