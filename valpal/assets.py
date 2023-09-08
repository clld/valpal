from pathlib import Path

from clld.web.assets import environment

import valpal


static_path = Path(valpal.__file__).parent / 'static'

environment.append_path(
    static_path.as_posix(),
    url='/valpal:static/')
environment.load_path = list(reversed(environment.load_path))
