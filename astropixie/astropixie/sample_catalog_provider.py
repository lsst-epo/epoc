import os.path

from astropy.coordinates import SkyCoord
from astropy import units as u

import numpy

from astropixie.types import OpenCluster, Star


class SampleCatalogProvider:
    def __init__(self):
        self.clusters = {
            OpenCluster('Berkeley 20', SkyCoord(ra='5h33m0s', dec='0h13m0s')):
            self.list_berkeley20,
            OpenCluster('Berkeley 20', SkyCoord(ra='5h33m0s', dec='0h13m0s')):
            self.list_berkeley20,
            OpenCluster('Berkeley 20', SkyCoord(ra='5h33m0s', dec='0h13m0s')):
            self.list_berkeley20,
        }

    def list_open_clusters(self):
        return list(self.clusters.keys())

    def list_stars(self, coord):
        for cluster, f in self.clusters.items():
            if cluster.coord == coord:
                return f()

        return []

    def list_berkeley20(self):
        datafile = self._get_sample_data_path('berkeley20.tsv')
        stars = numpy.genfromtxt(
            datafile, delimiter=';', skip_header=41,
            names=['Seq', 'Xpos', 'Ypos', 'Vmag', 'V_R', 'e_Vmag', 'e_Rmag']
        )

        results = []

        for star in stars:
            v_mag = star['Vmag']
            r_mag = (star['V_R'] * -1.0) + v_mag
            results.append(Star(v_mag, r_mag))

        return results

    def _get_sample_data_path(self, name):
        modPath = os.path.dirname(__file__)
        return os.path.join(modPath, 'sample_data', name)
