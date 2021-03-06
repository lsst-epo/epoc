import sys
import warnings
if not sys.warnoptions:
    warnings.simplefilter("ignore")

import astropixie
data = astropixie.data

from . import config
from .config import setup_notebook, show_with_bokeh_server

from . import visual
from . import science
from . import question
