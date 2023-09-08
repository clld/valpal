from pathlib import Path

from clld.web.assets import environment

import valpal


static_path = Path(valpal.__file__).parent / 'static'
download_path = static_path / 'download'

environment.append_path(
    static_path.as_posix(),
    url='/valpal:static/')
environment.append_path(
    download_path.as_posix(),
    url='/valpal:static/download/')
environment.load_path = list(reversed(environment.load_path))
