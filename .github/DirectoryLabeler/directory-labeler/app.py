import fileio
from manifest import Manifest
if __name__ == '__main__':
    manifests: list[Manifest] = fileio.lookup_directories()
    fileio.write_readme_each_directories(manifests)
    fileio.write_root_summary_readme(manifests)
