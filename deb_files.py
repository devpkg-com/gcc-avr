#!/bin/env python3

from collections import namedtuple
from datetime import datetime, timezone
from argparse import ArgumentParser

TIMEFORMAT = '%a, %d %b %Y %-H:%-M:%-S %z'

Entry = namedtuple('Entry', ('date', 'comment'))

chagelogs = (
    Entry(
        comment='''
  * Add configure options
    --enable-shared
    --enable-long-long
    --enable-nls
    --without-included-gettext
            ''',
        date=datetime(
            year=2020,
            month=3,
            day=25,
            hour=20,
            minute=17,
            second=43,
            tzinfo=timezone.utc,
        ),
    ),
    Entry(
        comment='''
  * Initial release
            ''',
        date=datetime(
            year=2020,
            month=2,
            day=25,
            hour=20,
            minute=17,
            second=43,
            tzinfo=timezone.utc,
        ),
    ),
)

ENTRY_TEMPLATE = """gcc-avr (1:{version}-{increment}) {distro}; urgency=medium

{comment}

-- admin <admin@devpkg.com> {timestamp}
"""


def render(num, args, entry):
    return ENTRY_TEMPLATE.format(
        version=args.version,
        increment=num,
        distro=args.codename,
        comment=entry.comment.strip('\n').rstrip(),
        timestamp=entry.date.strftime(TIMEFORMAT),
    )


if __name__ == "__main__":
    argParser = ArgumentParser(description='mikrotik api cli interface')
    argParser.add_argument(
        'version',
        type=str,
        help="destination version",
    )
    argParser.add_argument(
        'codename',
        type=str,
        help="destination codename",
    )
    args = argParser.parse_args()
    # sort by date in ascending order
    chlogs = sorted(chagelogs)
    rendered = tuple(render(num, args, entry) for num, entry in enumerate(chlogs, start=1))
    for item in reversed(rendered):
        print(item)
