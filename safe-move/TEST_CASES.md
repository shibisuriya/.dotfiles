# Test cases

Setting up unit testing or e2e testing is overkill for this project, execute these tests manually
before committing changes.

## 0 operand

```bash
safe-move -t a
```

## -t option missing

```bash
safe-move a.txt
```

## Argument for -t option missing

```bash
safe-move a.txt -t
```

## Duplicate operands

```bash
safe-move a.txt a.txt -t a
```

## Moving a directory into itself

```bash
safe-move a a
safe-move a a/b
```

## File's source & destination are same

```bash
safe-move a.txt ./
```

## Relative paths

```bash
safe-move ../safe-move/a.txt -d a
safe-move a.txt -d ../safe-move/a
```

## Moving a single file

```bash
safe-move a.txt -d a
safe-move a -d b
```

## Moving multiple files

```bash
safe-move a.txt b -d a
```
