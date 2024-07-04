from pathlib import Path
import string

def find_inconsistent_hyphenation(text: str) -> list[str]:
    types = set(tok.strip(string.punctuation) for tok in text.split())
    return sorted(typ for typ in types if "-" in typ and typ.replace("-", "") in types)

pg_text = Path("pg.md").read_text()
wikisource_text = Path("wikisource.md").read_text()
all_text = f"{pg_text} {wikisource_text}"

print(f"Project Gutenberg: {find_inconsistent_hyphenation(pg_text)}")
print(f"Wikisource: {find_inconsistent_hyphenation(wikisource_text)}")
print(f"All: {find_inconsistent_hyphenation(all_text)}")
