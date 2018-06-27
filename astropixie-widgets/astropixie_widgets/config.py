import logging
import os
from pathlib import Path
import urllib

from bokeh.io import show, output_notebook
from bokeh.resources import INLINE


def remote_jupyter_proxy_url(port):
    """
    Callable to configure Bokeh's show method when a proxy must be
    configured.

    If port is None we're asking about the URL
    for the origin header.
    """
    base_url = os.environ['EXTERNAL_URL']
    host = urllib.parse.urlparse(base_url).netloc

    # If port is None we're asking for the URL origin
    # so return the public hostname.
    if port is None:
        return host

    service_url_path = os.environ['JUPYTERHUB_SERVICE_PREFIX']
    proxy_url_path = 'proxy/%d' % port

    user_url = urllib.parse.urljoin(base_url, service_url_path)
    full_url = urllib.parse.urljoin(user_url, proxy_url_path)
    return full_url


# By default, use the remote_jupyter_proxy_url
jupyter_proxy_url = remote_jupyter_proxy_url


def _setup_logging(level):
    format_ = "%(asctime)s %(name)s-%(levelname)s "\
              "[%(pathname)s %(lineno)d] %(message)s"

    # Just in case basicConfig hasn't been called yet...
    # although many libraries will call it for us upon loading,
    # like bokeh.  But if none of them do, and basicConfig hasn't
    # been called before setup_notebook, call it here.
    # If basicConfig has already been called, this is ignored.
    logging.basicConfig(format=format_)

    # Set up the file, filehandler, and the formatter.
    filename = Path('~/ipynb.log').expanduser()
    filename.touch()

    handler = logging.FileHandler(filename=filename,
                                  encoding='utf-8', mode='a+')
    formatter = logging.Formatter(format_)
    handler.setFormatter(formatter)

    # Get the root logger, clear our uses of STDERR, and add our handler,
    # and set the root logger to the appropriate level.
    logger = logging.getLogger()
    logger.handlers.clear()
    logger.addHandler(handler)
    logger.setLevel(level)

    # If the bokeh logger is loaded before us, it messes with the config
    # in bokeh/util/logconfig.py.  Set it up to also use the log file,
    # and undo what it has done.
    bokeh_logger = logging.getLogger('bokeh')
    bokeh_logger.handlers.clear()
    bokeh_logger.addHandler(handler)


def setup_notebook(debug=False):
    """Called at the start of notebook execution to setup the environment.

    This will configure bokeh, and setup the logging library to be
    reasonable."""
    output_notebook(INLINE, hide_banner=True)
    if debug:
        _setup_logging(logging.DEBUG)
        logging.debug('Running notebook in debug mode.')
    else:
        _setup_logging(logging.WARNING)

    # If JUPYTERHUB_SERVICE_PREFIX environment variable isn't set,
    # this means that you're running JupyterHub not with Hub in k8s,
    # and not using run_local.sh (which sets it to empty).
    if 'JUPYTERHUB_SERVICE_PREFIX' not in os.environ:
        global jupyter_proxy_url
        jupyter_proxy_url = 'localhost:8888'
        logging.info('Setting jupyter proxy to local mode.')


def show_with_bokeh_server(obj, output=None):
    if output:
        with output:
            return show(obj, notebook_url=jupyter_proxy_url,
                        notebook_handle=True)
    else:
        return show(obj, notebook_url=jupyter_proxy_url,
                    notebook_handle=True)
