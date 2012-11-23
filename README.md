perlPathAnalysis
================

Perl Path Analysis - pull the paths out of a graph

Contains the perl script to generate paths from a list of nodes.

paths.pl 	- the perl script
\input		- example input files
\output		- outputs from the example input files
\modelgifs	- a gif for each of the input files showing the graph that the input file represents

This script is provided with no warranties, but you can have a look at the code and if you are happy with it then feel free to use it.

If you are not happy with it then feel free to re-write it.

I haven't used the code in earnest but it does seem to work and might prove useful.

Enjoy,

Alan Richardson
Compendium Developments Ltd, May 2000

alan@compendiumdev.co.uk

What is it?
------------

This is a very simple [Perl](http://www.perl.com) script which, when given a list of id node pairs, produces a list of the paths through the node set.

Feel free to re-use as much of it as is useful.

I will explain the use of the script using the first example in the archive (pairs1.txt) this is illustrated below. All the other examples can be found in the examples section. 

I have also written a small Critique of the tool which also covers the basic philosophy and usage of path analysis in passing.

The explanation is not intended to be a description of how to use flow graphs in testing, or path analysis or path sensitization - for treatment of these issues I recommend Beizer's "Black Box Testing" or Binder's "Testing Object-Oriented Systems", both of these books are reviewed in our [Testing Book Reviews](http://www.compendiumdev.co.uk/books/bookreviews.htm).

How to Use it
-------------
### Pairs1 -  a general flow graph with basic selections

The input below, looks like the model, and generates the output.

The test analyst has constructed a model of the part of the system under test, this is represented as a graph. In the real world the model probably has named nodes rather than numbers and possibly named edges.

In order to use the script the test analyst has to number the graph.

NOTE: If a node has a number of edges leading out of it then they are mutually exclusive. 

Having numbered the graph the tester constructs a node input file like the one shown in the diagram. I represent the starting condition as "-".

The input file is then fed into the perl script.

```
perl paths.pl pairs1.txt > outputpairs1.txt
```

I have chosen to have the output to stdout redirected to the outputpairs1.txt file.

#### input\pairs1.txt
```
- 0
0 1
1 2
1 3
3 9
9 4
3 5
5 6
5 7
7 8
7 9
```
#### Model

![pairs1.gif](https://gitbug.com/eviltester/perlPathAnalysis/raw/master/modelgifs/pairs1.gif)

#### output\outputpairs1.txt
```
- 0 1 2
- 0 1 3 9 4
- 0 1 3 5 6
- 0 1 3 5 7 8
- 0 1 3 5 7 9 4
```

Limitations
-----------
The input file only has the node pairs, it would obviously be useful to document the conditions under which those node pairs are actually valid as this would allow multiple links between the same two nodes and would be a greater help to the tester when analyzing the output.

The script has a crude understanding of loops and its strategy of looking for a node pair sequence twice in the trace may not be tight enough for you. Hence the large number of paths it finds in nested loop situations - but then testers are aware of the effect of combinatorial explosion so I suspect that most of your models will avoid those constructs. The script essential traverses each loop 1 and 2 times. But because it traverses loops within loops and links out it does more than a link coverage strategy and less than a heuristic loop coverage strategy.

Caveats
-------
This is a free script, you are free to use it and change it as much as you like.

However, you use it at your own risk. I do not want to be held responsible if you miss a path during testing because this script did not find it in your model.

Use it wisely and sensibly, conduct quality control on the input and output of the script and it should speed up your analysis of paths through models. 

As always, if you do make any improvements or find any defects I would be happy to hear from you.

I hope it helps your testing.

Examples
--------

#### Pairs1 - a general flow graph with basic selections

#### input\pairs1.txt
```
- 0
0 1
1 2
1 3
3 9
9 4
3 5
5 6
5 7
7 8
7 9
```
#### Model

![pairs1.gif](https://gitbug.com/eviltester/perlPathAnalysis/raw/master/modelgifs/pairs1.gif)

#### output\outputpairs1.txt
```
- 0 1 2
- 0 1 3 9 4
- 0 1 3 5 6
- 0 1 3 5 7 8
- 0 1 3 5 7 9 4
```