#!/usr/bin/env python3
"""Align inline comments in RRF G-code config/macro files.

Usage: tools/format-gcode.py [files...]        (default: sys/*.g *.g)

Rules:
- Full-line comments (line starts with ';') are left untouched.
- Inline comments are aligned to COMMENT_COL, or one space after the code
  if the code is longer than that.
- Consecutive unindented lines sharing the same command word form a block;
  parameter columns within a block are padded to the widest token, so e.g.
  M915/M208 groups line up. Quoted strings are kept whole.
- Indentation and code content are never changed. Semicolons inside quoted
  strings are not treated as comment starts.
"""
import sys
import glob

COMMENT_COL = 32


def split_comment(line):
    in_quote = False
    i = 0
    while i < len(line):
        c = line[i]
        if c == '"':
            in_quote = not in_quote
        elif c == ';' and not in_quote:
            return line[:i], line[i:]
        i += 1
    return line, None


def tokenize(code):
    """Split code into whitespace-separated tokens, keeping quoted strings whole."""
    tokens = []
    cur = ''
    in_quote = False
    for c in code:
        if c == '"':
            in_quote = not in_quote
            cur += c
        elif c.isspace() and not in_quote:
            if cur:
                tokens.append(cur)
                cur = ''
        else:
            cur += c
    if cur:
        tokens.append(cur)
    return tokens


def align_block(block):
    """Pad parameter columns of same-command lines to equal width.

    Only aligns when every line has the same sequence of parameter letters
    (e.g. all "X.. Y.. Z..", or all "P.. S.. H.. R.. F.."); otherwise columns
    would pair up semantically unrelated parameters.
    """
    if len(block) < 2:
        return
    rows = [tokenize(code) for code, _ in block]
    letters = [tuple(t[0] for t in r) for r in rows]
    if len(set(letters)) != 1:
        for j, r in enumerate(rows):
            block[j] = (' '.join(r), block[j][1])
        return
    ncols = min(len(r) for r in rows)
    widths = [max(len(r[i]) for r in rows) for i in range(ncols)]
    for j, (code, comment) in enumerate(block):
        row = rows[j]
        parts = [t.ljust(widths[i]) if i < ncols - 1 or len(row) > ncols
                 else t for i, t in enumerate(row[:ncols])] + row[ncols:]
        block[j] = (' '.join(parts).rstrip(), comment)


def format_file(path):
    with open(path) as f:
        original = f.read()

    # Parse lines into (kind, payload); collect alignable blocks of code lines.
    parsed = []       # ('raw', line) or ('code', index_into_blocks, offset)
    blocks = []       # each: list of (code, comment)
    for line in original.splitlines():
        stripped = line.lstrip()
        if not stripped or stripped.startswith(';') or line[0].isspace():
            parsed.append(('raw', line.rstrip() if stripped else line))
            blocks.append(None)
            continue
        code, comment = split_comment(line)
        parsed.append(('code', (code.rstrip(), comment.rstrip() if comment else None)))
        blocks.append(None)

    # Group consecutive code lines with the same command word and align them.
    i = 0
    while i < len(parsed):
        if parsed[i][0] != 'code':
            i += 1
            continue
        j = i
        cmd = tokenize(parsed[i][1][0])[0]
        while j < len(parsed) and parsed[j][0] == 'code' \
                and tokenize(parsed[j][1][0])[0] == cmd:
            j += 1
        block = [parsed[k][1] for k in range(i, j)]
        align_block(block)
        for k in range(i, j):
            parsed[k] = ('code', block[k - i])
        i = j

    out = []
    for kind, payload in parsed:
        if kind == 'raw':
            out.append(payload)
        else:
            code, comment = payload
            if comment is None:
                out.append(code)
            else:
                out.append(code + ' ' * max(COMMENT_COL - len(code), 1) + comment)

    result = '\n'.join(out) + '\n'
    if result != original:
        with open(path, 'w') as f:
            f.write(result)
        return True
    return False


def main():
    files = sys.argv[1:] or sorted(glob.glob('sys/*.g') + glob.glob('*.g'))
    for path in files:
        status = 'formatted' if format_file(path) else 'unchanged'
        print(f'{status}  {path}')


if __name__ == '__main__':
    main()
