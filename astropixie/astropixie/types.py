class OpenCluster(object):
    def __init__(self, friendlyName, skyCoords):
        self.name = friendlyName
        self.coord = skyCoords

    def __repr__(self):
        return '<astropixie.OpenCluster %s %s>' % (self.name, self.coord)


class Star(object):
    def __init__(self, Vmag, Rmag):
        self.Vmag = Vmag
        self.Rmag = Rmag

    def __repr__(self):
        return '<astropixie.Star V=%f R=%f>' % (self.Vmag, self.Rmag)
