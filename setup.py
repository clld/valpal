from setuptools import setup, find_packages

ENTRY_POINTS = """\
[paste.app_factory]
main = valpal:main
"""

setup(
    name='valpal',
    version='0.0',
    description='valpal',
    classifiers=[
        "Programming Language :: Python",
        "Framework :: Pyramid",
        "Topic :: Internet :: WWW/HTTP",
        "Topic :: Internet :: WWW/HTTP :: WSGI :: Application"],
    author='',
    author_email='',
    url='',
    keywords='web pyramid pylons',
    packages=find_packages(),
    include_package_data=True,
    zip_safe=False,
    install_requires=[
        'clld>=9.2.2',
        'clld-glottologfamily-plugin>=4.0',
        'pyglottolog',

        'clldmpg',

        'psycopg2',
        'markdown',
    ],
    extras_require={
        'dev': ['flake8', 'waitress'],
        'test': [
            'mock',
            'pytest>=5.4',
            'pytest-clld',
            'pytest-mock',
            'pytest-cov',
            'coverage>=4.2',
            'selenium',
            'zope.component>=3.11.0'
        ],
    },
    test_suite="valpal",
    entry_points=ENTRY_POINTS)
