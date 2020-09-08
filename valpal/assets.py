from pathlib import Path

from clld.web.assets import environment

import valpal


environment.append_path(
    Path(valpal.__file__).parent.joinpath('static').as_posix(),
    url='/valpal:static/')
environment.load_path = list(reversed(environment.load_path))
