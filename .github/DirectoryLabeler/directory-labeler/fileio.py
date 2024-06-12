from os import listdir
from os.path import isdir, isfile, join
from manifest import Manifest

def lookup_directories():
    dirs = listdir()
    manifests: dict[str, Manifest] = {}
    for dir in dirs:
        if not isdir(dir):
            continue
        manifest_path = join(dir, 'manifest.toml')
        if not isfile(manifest_path):
            continue
        manifest_raw = open(manifest_path, encoding='utf-8').read()
        manifest = Manifest(manifest_raw)
        manifests[dir] = manifest
    return manifests

def write_readme_each_directories(manifests: dict[str, Manifest]):
    for dir in manifests:
        if not isdir(dir):
            continue
        manifest = manifests[dir]
        template_path = join(dir, 'template.md')
        template = open(template_path, encoding='utf-8').read() if isfile(template_path) else '{summary}'
        with open(join(dir, 'README.md'), 'w', encoding='utf-8') as f:
            f.write(template.format(summary=manifest.render()))

rs_each_lecture_summary = '| {code} | [{name}({prof}, {opened_at})]({path}) | @{dept} |'
def write_root_summary_readme(manifests: dict[str, Manifest]):
    template = open('template.md').read() if isfile('template.md') else '{summary}'
    content = []
    for dir in sorted(manifests):
        manifest = manifests[dir]
        content.append(
            rs_each_lecture_summary.format(
                name=manifest.name,
                code=manifest.code,
                opened_at=Manifest.f_opened_at(manifest.opened_at),
                prof=manifest.prof,
                dept=manifest.dept,
                path=f'./{dir}'
            )
        )
    summary = '\n'.join(['| | 과목명 | |', '| :-: | :-: | :-: |'] + content)
    with open('README.md', 'w', encoding='utf-8') as f:
        f.write(template.format(summary=summary))
