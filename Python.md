

### Errors
Exception: Base class for all built-in exceptions except StopIteration and SystemExit.
AttributeError: Raised when an attribute reference or assignment fails.
IOError: Raised when an I/O operation (such as a print statement, the built-in open() function or a method of a file object) fails for an I/O-related reason, e.g., "file not found" or "disk full" (not used in Python 3, replaced by OSError).
ImportError: Raised when an import statement fails to find the module definition or when a from ... import fails to find a name that is to be imported.
IndexError: Raised when a sequence subscript is out of range.
KeyError: Raised when a dictionary key is not found.
NameError: Raised when a local or global name is not found.
OSError: Raised for operating system-related errors.
SyntaxError: Raised when the parser encounters a syntax error.
TypeError: Raised when an operation or function is applied to an object of inappropriate type.
ValueError: Raised when a built-in operation or function receives an argument that has the right type but an inappropriate value.
ZeroDivisionError: Raised when the second argument of a division or modulo operation is zero.


### Underscore 

```python
5+3
_  # last executed expression

a, _, c = (1, 2, 3) # ignore values in assignment

_var # private variable or method
var_ # avoid confilict with a keyword
__var # avoid conflict with subclasses
__var__ # reserved for special use


```

### Shortcut keys
- Insert a new line directly below, regardless of where you are in the current line: ^ + ⏎
- Duplicate your current row up or down: ⎇ + ⇧ + ↑/↓
- Move the current row up or down: ⎇ + ↑/↓
- Select everything within the current bracket (hit twice): ⎇ + ⇧ + →
- Comment out the current line: ^ + /
- Indent lines inward or outward: ^ + [ or ]
