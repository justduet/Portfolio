# modules, aliases
# every module has a special value (name)

from math import pi
import sys
import random as rdm
from enum import Enum
from rps7 import rock_paper_scissors


print(pi)

rdm.choice("123")

# how to see what's inside
for item in dir(rdm):
    print(item)

rdm.choices

print(__name__)
print(rdm.__name__)

rock_paper_scissors()
