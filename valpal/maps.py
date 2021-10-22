from collections import ChainMap

from clld.web.maps import ParameterMap, Layer


class VerbMap(ParameterMap):
    def get_options(self):
        opts = super().get_options()
        return ChainMap(
            {'show_labels': True},
            opts)


def includeme(config):
    config.register_map('parameter', VerbMap)
