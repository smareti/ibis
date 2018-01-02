"""Setup file."""
import os
from setuptools import setup, find_packages
from setuptools.command.install import install
from pip.req import parse_requirements

# Utility function to read the README file.
# Used for the long_description.  It's nice, because now 1) we have a top level
# README file and 2) it's easier to type in the README file than to put a raw
# string in below ...


def read(fname):
    """Read file."""
    return open(os.path.join(os.path.dirname(__file__), fname)).read()

# Dynamically get the IBIS version so that we don't have
# to update it in 3 places anymore
with open('ibis_version.sh', 'r') as fh:
    lines = fh.readlines()
    _, ibis_version = lines[1].split('=')
    _, ibis_app_name = lines[2].split('=')
    ibis_version = ibis_version.strip()
    ibis_app_name = ibis_app_name.strip()


with open('requirements.pip') as f:
    ibis_deps = f.read().splitlines()


class CustomInstallCommand(install):
    """Customized setuptools install command - prints a friendly greeting."""

    def run(self):
        """deploy ibis egg"""
        install.run(self)
        print "Custom install ----\n"


# Info on creating a setup.py file:
# https://pythonhosted.org/an_example_pypi_project/setuptools.html
setup(
    name=ibis_app_name,
    version=ibis_version,
    packages=find_packages(),

    package_data={
        # If any package contains *.txt or *.rst files, include them:
        '': ['*.properties', '*.xml', '*.ksh', '*.mako',
             '*.sh', '*.hql', '*.wld', '*txt', '*.feature'],
    },
    data_files=[('.', ['README.md', '__main__.py',
                       'ibis_int_tests.py', 'behavior_tests.py'])],

    install_requires=ibis_deps,
    # setup_requires=ibis_deps,
    include_package_data=True,

    author="Big Data Analytics & Shared Services Team (Hadoop)",
    author_email="fake_email",
    description="Ibis: Workflow and Ingestion Made Easy",
    keywords="hadoop oozie workflows bigdata ingest",
    cmdclass={
        'install': CustomInstallCommand
    },
    # project home page, if any
    url="fake_home_page",
    entry_points={
        'setuptools.installation': [
            'eggsecutable = ibis.driver.main:main'
        ]
    }
)