from setuptools import setup

setup(name='astropixie',
      version='0.0.1',
      description='EPO data client',
      url='https://github.com/lsst-epo/vela',
      author='Christine Banek',
      author_email='cbanek@lsst.org',
      license='MIT',
      packages=['astropixie'],
      include_package_data=True,
      package_data={'astropixie': ['mock_data/*']},
      install_requires=[
        'pytest',
        'numpy',
        'astropy'
      ])
