c.TerminalInteractiveShell.editing_mode = 'vi'

c.InteractiveShellApp.exec_lines = [
    'from organization.models import *;'
    'from brain.models import *;'
    'from more_itertools import flatten, chunked;'
    'from pprint import pp;'
    'from collections import Counter, defaultdict;'
    'from djangocommon import conversation_utils;'
    'from django.utils import timezone;'
]
