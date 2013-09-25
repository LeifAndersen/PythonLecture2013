#lang slideshow

(require slideshow/play
         slideshow/code
         slideshow/latex
         (for-syntax syntax/stx)
         "slideshow-macros.rkt")

(title-slide
 (scale (bitmap "python-logo.gif") 4)
 (colorize (medium-text "Leif Andersen") "blue")
 (colorize (t "University of Utah") "red"))

(pretty->flip-slide
 (massive-text "What is Python?"))

(flip->pretty-slide
 (large-text "An interpreted, interactive,")
 (large-text "object-oriented")
 (large-text "programming language."))

(pretty-slide
 (medium-text "Reasons to use Python"))

(pretty-slide
 #:title "Reasons to use Python"
 (item "Develop faster.")
 'next
 (item "Write cleaner code.")
 'next
 (item "Scientific Computing."))


(insert-slide
 #:append 'center-h
 #:left (medium-text "Reasons ")
 #:right (medium-text "to use Python")
 #:insert (colorize (medium-text "NOT ") "red"))

(pretty-slide
 #:title "Reasons NOT to use Python"
 (item "Can be slower.")
 'next
 (item "Scalability issues.")
 'next
 (item "Library incompatibilities."))

(pretty-slide
 (scale (bitmap "bananaphone.jpg") 2))

(start-pretty-slide
 (hc-append 0
            (large-text "Compiled ")
            (massive-$$ ">")
            (large-text " Interpreted")))

(transition-insert-slide
 #:append 'center-h
 #:reversed #t
 #:left (large-text "Compiled ")
 #:right (large-text " Interpreted")
 #:insert (massive-$$ ">"))

(transition-insert-slide
 #:append 'center-h
 #:left (large-text "Compiled ")
 #:right (large-text " Interpreted")
 #:insert (massive-$$ "<"))

(slide
 (hc-append 0
            (large-text "Compiled ")
            (massive-$$ "<")
            (large-text " Interpreted")))

(transition-insert-slide
 #:append 'center-h
 #:reversed #t
 #:left (large-text "Compiled ")
 #:right (large-text " Interpreted")
 #:insert (massive-$$ "<"))

(transition-insert-slide
 #:append 'center-h
 #:left (large-text "Compiled ")
 #:right (large-text " Interpreted")
 #:insert (massive-$$ "="))

(end-pretty-slide
 (hc-append 0
            (large-text "Compiled ")
            (massive-$$ "=")
            (large-text " Interpreted")))

(pretty-slide
 (massive-text "Hello World"))

(section
 #:title "Hello World!"
 (picture-slide
  #:fade-in #t
  #:fade-out #f
  (vl-append
   0
   (tt "public class Hello {")
   (tt "  public static void main(String[] args) {")
   (tt "    System.out.println(\"Hello World!\");")
   (tt "  }")
   (tt "}"))
  (scale (tt "\"Hello World!\"") 2))

 (transition-slide
  #:append 'center-h
  #:header (scale (tt "\"Hello World!\"") 2)
  #:left (scale (tt "print(") 2)
  #:right (scale (tt ")") 2))

 (end-pretty-slide
  (scale (tt "print(\"Hello World!\")") 2)))

(acronym-slide
 #:acronym (massive-text "REPL")
 (large-text "Read")
 (large-text "Eval")
 (large-text "Print")
 (large-text "Loop"))

(start-pretty-slide
 (large-text "Turning this:"))

(transition-slide
 #:header (large-text "Turning this:")
 (bitmap "computer.jpg"))

(picture-slide
 #:fade-in #f
 #:fade-out #t
 (vc-append 0
            (large-text "Turning this:")
            (bitmap "computer.jpg"))
 (vc-append 0
            (large-text "Into This:")
            (bitmap "calc.gif")))

(section
 #:title "Arithmetic"
 (pretty->flip-slide
  (scale (scode #:append 'center "<exp> + <exp>
<exp> - <exp>
<exp> * <exp>
<exp> / <exp>
<exp> // <exp>
<exp> ** <exp>") 1.5))

 (flip->pretty-slide
  (scale (scode #:append 'center "5 + 3
3 - 1
4 * 5
2 / 9
1 // 2
2 ** 10") 1.5)))

(section
 #:title "Comparators"
 (pretty->flip-slide
  (scale (scode #:append 'center "<exp> == <exp>
<exp> != <exp>
<exp> > <exp>
<exp> < <exp>
<exp> >= <exp
<exp> <= <exp>
<exp> is <exp>
<exp> in <collection>") 1.5))
 (flip->pretty-slide
  (scale (scode #:append 'center "1 == 3
5 != 3
18 > 3
5 < 5
134 >= 2
5 <= 14
8 != 3
5 is 5
5 in {1, 5, 10}") 1.5)))

(section
 #:title "Boolean logic"
 (pretty-slide
  (scale (scode #:append 'center "True
False") 3))
 (pretty-slide
  (scale (scode #:append 'center "and
or
not") 3))
 (start-pretty-slide
  (scale (scode "not True") 5))
 (shrink-transition-slide
  #:start-size 5
  #:end-size 1
  (scode "not True"))
 (transition-slide
  #:append 'left
  #:header (scode "not True")
  (scode " and False or True and (True or False)"))
 (pretty->flip-slide
  #:fade-in #f
  (scode "not True and False or True and (True or False)"))
 (flip->pretty-slide
  (scode "((not True) and False) or (True and (True or False))")))

(pretty-slide
 (massive-text "Variables"))

(section
 #:title "Variables"
 (pretty->flip-slide
  (scale (tt "<var> = <val>") 3))

 (flip-slide
  (scale (tt "x = 2") 3))

 (flip->pretty-slide
  (scale (scode "x = 1 + 5") 3))

 (pretty-slide
  (scode "x = 5
y = str(x)
z = int(z)
a = float(z)"))
 )

(pretty-slide
 (massive-text "Lists"))

(section
 #:title "Lists"
 (pretty->flip-slide
  (scale (scode "[<item0>, <item1>, ..., <itemn>]") 1.5))

 (flip->pretty-slide
  (scale (scode "x = [0, 1, 2, 3]") 2))

 (pretty-slide
  (large-text "Length of a list"))

 (header-slide
  #:header (scale (scode "x = [1, 2, 3]") 2)
  (scale (scode "len(x)") 2))

 (pretty-slide
  (massive-text "append to a list"))

 (header-slide
  #:append 'top-l
  #:header (scode "x = [1, 2, 5
x.append(3)")
  (scode "print(x) # [1, 2, 5, 3]"))

 (pretty-slide
  (massive-text "List Indexing"))

 (header-slide
  #:append 'top-l
  #:header (scode "x = [\"red\", \"green\", \"blue\"]
print(x[2]) # blue")
  (scode "x[1] = \"yellow\"
print(x) # [\"red\", \"yellow\", \"blue\"]"))
 )

(pretty-slide
 (massive-text "while loops"))

(section
 #:title "While Loops"
 (pretty->flip-slide
  (scale (scode "while <condition>:
    <exp>") 2))

 (flip->pretty-slide
  #:fade-out #f
  (scale (scode "while True:
    print(\"y\")") 2))

 (transition-slide
  #:append 'bottom-l
  #:reversed #t
  #:header (scale (scode "    print(\"y\")") 2)
  (scale (scode "while True") 2))

 (transition-slide
  #:append 'bottom-l
  #:header (scale (scode "    print(\"y\")") 2)
  (scale (scode "while 18 > 3:") 2))

 (end-pretty-slide
  (scale (scode "while 18 > 3:
    print(\"y\")") 2))

 (pretty-slide
  (large-text "Note the Whitespace"))

 (pretty-slide
  (scale (scode "while 1 == 1:
    print(\"I'm in the loop.)\"
print(\"I'm not in the loop.\")") 1))

 (start-pretty-slide
  (large-text "A word on variable scope"))

 (transition-slide
  #:header (large-text "A word on variable scope")
  (large-text "Loops do not create new scope"))

 (picture-slide
  #:fade-in #f
  #:fade-out #t
  (vc-append 0
             (large-text "A word on variable scope")
             (large-text "Loops do not create new scope"))
  (scale (bitmap "head-scratch.jpg") 1.75))

 (pretty-slide
  (scale (scode "i=1
while i < 10:
    i = i + 1
    tmp = i
print(tmp) # 10") 1.5))
 )

(pretty-slide
 (massive-text "for loops"))

(section
 #:title "for loops"

 (pretty-slide
  (large-text "Like Java's for/each loop"))

 (pretty->flip-slide
  (scale (scode "for <var> in <collection>:
    <exp>") 1.5))

 (flip->pretty-slide
  (scale (scode "for i in [1, 2, 3, 4, 5]:
    print(i)") 1.5))

 (pretty-slide
  (medium-text "Creating Java style for loops"))

 (header-slide
  #:header (scode "x = [1, 2, 3, 4, 5]
for i in len(range(x)):
    print(x[i])")
 (colorize (massive-text "Don't do this!") "red")
 (t "(It's ugly)"))
 )

(pretty-slide
 (massive-text "functions"))

(section
 #:title "functions"
 (pretty->flip-slide
  (scale (scode "def <name>(<args>):
    <body>") 2))

 (flip->pretty-slide
  (scale (scode "def sum(a, b):
    return a + b") 2))

 (header-slide
  #:header (large-text "A word on scope:")
  (hc-append 0
             (large-text "Functions ")
             (colorize (massive-text "DO") "red")
             (large-text " make new scope.")))
 (pretty->flip-slide
  (large-text "A bigger function"))

 (flip->pretty-slide
  (scale (scode "def sum_range(a, b):
    sum = 0
    for i in range(a, b):
        sum += i
    return sum") 2)))

(pretty-slide
 (massive-text "sets")
 (massive-text "dicts"))

(section
 #:title "sets, dicts"

 (insert-slide
  #;append 'center-h
  #:left (scale (scode "x = {1, 2, 3") 2)
  #:right (scale (scode "}") 2)
  #:insert (scale (scode ", 1") 2))

 (header-slide
  #:append 'top-l
  #:header (scale (scode "y = {\"red\": 5,
  \"blue\": 10,
  \"orange\": 42}") 2)
  (scale (scode "print(y[\"orange\"]) # 42
y[\"yellow\"] = 10") 2))

 (picture-slide
  (scale (scode "{}") 8)
  (bitmap "black-hole.jpg")))

(pretty->flip-slide
 (massive-text "classes"))

(flip->pretty-slide
 (scale (bitmap "mario.jpg") 1.5))

(pretty->flip-slide
 (large-text "Running a Python file"))

(flip-slide
 (scale (scode "python3 <filename>") 2))

(flip->pretty-slide
 (scale (scode "python3 foo.py") 2))

(pretty-slide
 (hc-append 0
            (large-text "Why ")
            (scale (scode "python3") 2)))

(pretty-slide
 (massive-text "Homework")
 (bitmap "homework.jpg"))

(pretty-slide
 #:title "Homework"
 (item "Download Python")
 'next
 (item "Make factorial function")
 'next
 (item "Use python to solve some math problems.")
 'next
 (item "Do something cool with python (pygame, numpy, etc.).")
 'next
 (item "Fill out the survey"))

(pretty->flip-slide
 (massive-text "Python 2 vs. 3"))

(flip->pretty-slide
 (scale (scode "print \"text\"") 2)
 (massive-text "VS")
 (scale (scode "print(\"text\")") 2))

(header-slide
 #:header (double-massive-text "CADE")
 (large-text "Use python3"))

(pretty-slide
 (large-text "Recommended Tools"))

(pretty-slide
 #:title "Recommended Tools"
 (item "bpython3")
 'next
 (item "Pydev/Aptana Studio (Eclipse Environment")
 'next
 (item "PDB (good with emacs)"))

(pretty-slide
 (large-text "Recommended Resources"))

(pretty-slide
 #:title "Recommended Resources"
 (item "Python API")
 'next
 (item "Stack Overflow")
 'next
 (item "Google"))

(header-slide
 #:header (massive-text "Questions?")
 (colorize (large-text "leif@leifandersen.net") "blue"))
