#!/usr/bin/env python

import os
from setuptools import setup, find_packages


original_dir = os.getcwd()
os.chdir(os.path.dirname(os.path.abspath(__file__)))
try:
    setup(
        name="Introspy-Analyzer",
        version=__import__("introspy").__version__,
        packages=find_packages(),
        include_package_data=True,
        zip_safe=False,

        # metadata for upload to PyPI
        author=__import__("introspy").__author__,
        author_email="nabla.c0d3@gmail.com",
        description="Introspy-Analyzer",
        license="GPL",
        keywords="ios android",
        url="https://isecpartners.github.io/Introspy-iOS/",
        long_description=open("README.md").read(),
        classifiers=[
            'Development Status :: 4 - Beta',
            'Intended Audience :: Developers',
            'License :: OSI Approved :: GPL License',
            'Operating System :: OS Independent',
            'Programming Language :: Python',
            'Programming Language :: Python :: 2',
            'Topic :: Software Development :: Libraries :: Python Modules'
        ],
        platforms='All',
    )

finally:
    os.chdir(original_dir)
