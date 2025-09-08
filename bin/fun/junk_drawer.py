#!/usr/bin/env python3
"""Junk Drawer Simulator / Generator"""

import argparse
import json
import random


def main():
    """Program Entrypoint"""

    parser = argparse.ArgumentParser(
        description="Junk Drawer Simulator",
        epilog="Typical use: just for fun :-)")
    parser.add_argument(
        "-c", "--count", default=1,
        type=int, required=False,
        help="How many items are in the junk drawer (default = 1).",
        metavar="CNT", dest="items_count")
    parser.add_argument(
        "-j", "--json-output",
        help="Enable JSON output.",
        action="store_true", dest="json_enabled")
    args = parser.parse_args()

    items = get_items(args.items_count)

    if args.json_enabled:
        json_data = {}
        json_data["junk_drawer_contents"] = items
        print(json.dumps(json_data, indent=2))
    else:
        print("Junk Drawer Contents:")
        for i in items:
            print("  -", i)
        print("And remember: You need to put bulky objects in the rear so they can interfere with the drawer opening.")


def get_items(count: int) -> list:

    # NOTE: Edit the junk drawer's list as needed.
    junk_drawer = []
    junk_drawer.append("Keys you don't know or remember. Bonus for an empty keyring.")
    junk_drawer.append("Random batteries. Dead batteries. Mix and mismatch to be sure.")
    junk_drawer.append("Two pairs of scissors: the good ones and the dull ones. They both look the same.")
    junk_drawer.append("Three half-used rolls of scotch tape including one off-brand.")
    junk_drawer.append("Old and dry rubber bands. Your fingers need to be snapped.")
    junk_drawer.append("Random office supplies. Who uses that anyway?")
    junk_drawer.append("Pens. From the bank, the insurance company, etc. Some might work.")
    junk_drawer.append("USB cables. Some are power-only, some are data-only. Take your chance.")
    junk_drawer.append("Old non-standard charging cables for devices that you don't own anymore.")
    junk_drawer.append("Allen keys. From IKEA, mostly. None fits the screw you have at hand.")
    junk_drawer.append("About 5 takeout menus with at least one from a place that went out of business.")
    junk_drawer.append("Instruction manuals for appliances you no longer own.")
    junk_drawer.append("A mini hand sanitizer bottle, half empty.")
    junk_drawer.append("A wooden pencil, broken. No sharpener in sight.")
    junk_drawer.append("A random assortment of about 5 to 10 screws that are never the length you need.")
    junk_drawer.append("A lighter that may or may not work. Hoping for a spark in darkness.")
    junk_drawer.append("One of those cheap folding corkscrews. Bonus points if it's rusty.")
    junk_drawer.append("Mesuring tape that does not come back by itself.")
    junk_drawer.append("One single Post-It. Not the whole pad, just one.")
    junk_drawer.append("Candles you keep for emergencies. They won't light up, but you know they are there.")
    junk_drawer.append("An old combination lock. The numbers on the back are erased, torn or faded.")

    # The random.sample() functions needs a value between 1 and len().
    # Anything above or below will throw an exception.
    if count > len(junk_drawer):
        count = len(junk_drawer)
    if count < 1:
        count = 1

    return random.sample(junk_drawer, count)


if __name__ == "__main__":
    main()
