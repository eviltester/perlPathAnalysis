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

#### [input\pairs1.txt](https://github.com/eviltester/perlPathAnalysis/blob/master/input/pairs1.txt)
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

![pairs1.gif](https://raw.github.com/eviltester/perlPathAnalysis/master/modelgifs/pairs1.gif)

#### [output\outputpairs1.txt](https://github.com/eviltester/perlPathAnalysis/blob/master/output/outputpairs1.txt)
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

This section illustrates the examples in the downloadable archive. As you can see the simple algorithm for loop detection used by the script generates a lot of paths for the nested loop examples.

### Pairs1 - a general flow graph with basic selections

##### [input\pairs1.txt](https://github.com/eviltester/perlPathAnalysis/blob/master/input/pairs1.txt)
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
##### Model

![pairs1.gif](https://raw.github.com/eviltester/perlPathAnalysis/master/modelgifs/pairs1.gif)

##### [output\outputpairs1.txt](https://github.com/eviltester/perlPathAnalysis/blob/master/output/outputpairs1.txt)
```
- 0 1 2
- 0 1 3 9 4
- 0 1 3 5 6
- 0 1 3 5 7 8
- 0 1 3 5 7 9 4
```

### Pairs2 - a general flow graph with basic selections

#### [input\pairs2.txt](https://github.com/eviltester/perlPathAnalysis/blob/master/input/pairs2.txt)
```
-  0
0  1
1  2
1  3
2  4
3  8
3  13
8  9
8  10
9  4
10 4
13 4
4  5
4  6
5  14
6  14
14 7
```
##### Model

![pairs2.gif](https://raw.github.com/eviltester/perlPathAnalysis/master/modelgifs/pairs2.gif)

##### [output\outputpairs2.txt](https://github.com/eviltester/perlPathAnalysis/blob/master/output/outputpairs1.txt)
```
- 0 1 2 4 5 14 7
- 0 1 2 4 6 14 7
- 0 1 3 8 9 4 5 14 7
- 0 1 3 8 9 4 6 14 7
- 0 1 3 8 10 4 5 14 7
- 0 1 3 8 10 4 6 14 7
- 0 1 3 13 4 5 14 7
- 0 1 3 13 4 6 14 7
```

### Loop - a simple loop

As you can see the loop is traversed twice by the script's algorithm.

#### [input\loop.txt](https://github.com/eviltester/perlPathAnalysis/blob/master/input/loop.txt)
```
- 1
1 2
2 3
2 5
3 4
5 7
6 5
7 4
7 6
```
##### Model

![loop.gif](https://raw.github.com/eviltester/perlPathAnalysis/master/modelgifs/loop.gif)

##### [output\outputloop.txt](https://github.com/eviltester/perlPathAnalysis/blob/master/output/outputloop.txt)
```
- 1 2 3 4
- 1 2 5 7 4
- 1 2 5 7 6 5 7 4
- 1 2 5 7 6 5 7 6 5 7 4
```

### Nested Loop - a simple nested loop

#### [input\nestedloop.txt](https://github.com/eviltester/perlPathAnalysis/blob/master/input/nestedloop.txt)
```
- 1
1 2
1 3
3 4
4 5
5 7
7 4
5 6
6 8
8 3
6 9
2 9
```
##### Model

![loop.gif](https://raw.github.com/eviltester/perlPathAnalysis/master/modelgifs/nested.gif)

##### [output\outputnest.txt](https://github.com/eviltester/perlPathAnalysis/blob/master/output/outputnest.txt)
```
- 1 2 9
- 1 3 4 5 7 4 5 7 4 5 6 8 3 4 5 6 9
- 1 3 4 5 7 4 5 7 4 5 6 9
- 1 3 4 5 7 4 5 6 8 3 4 5 7 4 5 7 4 5 6 8 3 4 5 6 9
- 1 3 4 5 7 4 5 6 8 3 4 5 7 4 5 7 4 5 6 9
- 1 3 4 5 7 4 5 6 8 3 4 5 7 4 5 6 8 3 4 5 7 4 5 7 4 5 6 9
- 1 3 4 5 7 4 5 6 8 3 4 5 7 4 5 6 8 3 4 5 7 4 5 6 9
- 1 3 4 5 7 4 5 6 8 3 4 5 7 4 5 6 8 3 4 5 6 9
- 1 3 4 5 7 4 5 6 8 3 4 5 7 4 5 6 9
- 1 3 4 5 7 4 5 6 8 3 4 5 6 9
- 1 3 4 5 7 4 5 6 9
- 1 3 4 5 6 8 3 4 5 7 4 5 7 4 5 6 8 3 4 5 6 9
- 1 3 4 5 6 8 3 4 5 7 4 5 7 4 5 6 9
- 1 3 4 5 6 8 3 4 5 7 4 5 6 8 3 4 5 7 4 5 7 4 5 6 9
- 1 3 4 5 6 8 3 4 5 7 4 5 6 8 3 4 5 7 4 5 6 9
- 1 3 4 5 6 8 3 4 5 7 4 5 6 8 3 4 5 6 9
- 1 3 4 5 6 8 3 4 5 7 4 5 6 9
- 1 3 4 5 6 8 3 4 5 6 9
- 1 3 4 5 6 9
```

### 3 Nested Loop (1) - a 3 way nested loop

#### [input\3nested.txt](https://github.com/eviltester/perlPathAnalysis/blob/master/input/3nested.txt)
```
- 1
1 2
1 3
3 4
4 3
4 5
5 3
5 6
6 3
6 10
```
##### Model

![loop.gif](https://raw.github.com/eviltester/perlPathAnalysis/master/modelgifs/3nested1.gif)

##### [output\output3nest.txt](https://github.com/eviltester/perlPathAnalysis/blob/master/output/output3nest.txt)
```
138 paths identified, 
please see the file in the archive
```

### 3 Nested Loop (2) - a 3 way nested loop with additional branch

This highlights the effects of combinatorial explosion in testing.

#### [input\3nested2.txt](https://github.com/eviltester/perlPathAnalysis/blob/master/input/3nested2.txt)
```
- 1
1 2
1 3
3 4
4 3
4 5
4 7
7 6
5 3
5 6
6 3
6 10
```
##### Model

![loop.gif](https://raw.github.com/eviltester/perlPathAnalysis/master/modelgifs/3nested2.gif)

##### [output\output3nest2.txt](https://github.com/eviltester/perlPathAnalysis/blob/master/output/output3nest2.txt)
```
2,971 paths identified,
please see the file in the archive
```

Critique
--------

### A more detailed analysis of the algorithm's limitations

The script as written is a naive tester. He very thoroughly addresses link coverage and that is why he gets so many paths, but the problem is that there is nothing in the presented result set that suggests priorities; every path is presented as an equal.

This may or may not be true, but from the information contained in the graph it isn't really applicable to present such a detailed analysis of the paths in the model as, in the case of example "3 nested loop (2)" the important paths can get lost among the morass of loop coverage.

It would be better, and I think that most testers will do this either consciously or unconsciously, to present the following details for link coverage:

* Each sequential path should be presented and covered.
* Each loop path should be presented as a meta path and not unrolled.

Loop is very simple:

![loop.gif](https://raw.github.com/eviltester/perlPathAnalysis/master/modelgifs/loop.gif)

Our sequential paths in the above model are:

* 1 2 3 4
* 1 2 5 7 4

Our meta path is:

* 1 2 [5 7 6]* 5 7 4

In order to read an understand the meta path we have to know that []* represents a loop construct which occurs from 1 to Many times. The exit condition for the loop may well be documented in the graph as part of the weighting for a predicate node link but the script does not support this.

The script has no concept of a meta path, indeed the script has a variety of hack constructs to try and identify loops in order to prevent the processing time approaching infinity.

The script, although it is unaware of it, applies the "Once" and the "Twice" strategies to the meta path.

In the above example the "Once" strategy will achieve link coverage and the "Twice" strategy is overkill. It may be important but not in terms of the information in the model.

The script presents the meta path as two unrolled sequential paths. This is valid in terms of writing scripts and associating scripts with tests where the script must be executed in the same way each time so non-deterministic loops will not be represented, and indeed loops will often be unrolled.

This is most seriously demonstrated by example "3 nested loop (2)":

![loop.gif](https://raw.github.com/eviltester/perlPathAnalysis/master/modelgifs/3nested2.gif)

The script has identified 2,971 paths. That's great, that tells us that although the model is small, it hides a great deal of complexity and correspondingly may have been tricky to implement and may be a den of defects.

The problem is that the script has presented us with too much information, what we actually want to see, and what will be represented in the tester's mental model for link coverage, is in fact 3 paths:

* 1 2
* 1 [[3 4]* 7 6]* 10
* 1 [[[3 4]* 5]* 6]* 10

This representation is enough to cover the links. It should be noted that none of the links that cause a loop to repeat will be covered unless the loops are traversed twice as the loops are post test and not pre test. i.e. do ... while, rather than while...do.

That is pretty much all I wanted to say on this subject to highlight the limitations of the script and to begin to highlight some of the processes that occur in the testers mind. But, and I think the last model presents it best, testing is not simple. The 3 paths above provide link coverage but they are not completely representative of the tests that a tester would construct from that model. The path 1 3 4 5 3 4 7 6 10 is not represented by the meta paths above. The meta paths were constructed on the basis of link coverage and link coverage does not represent all that a tester does.

A slightly malformed meta representation of the path can be formed by combining the two meta paths above into 1 [3 4]* [(7 6]*)|(5]*6]*)] 10. It is malformed because I haven't equalised the brackets. 

A far better representation is 1 [3 [ 2 ( [1 3 4 ]*1 7 )|( [2 [ 1 3 4 ]*1 5 ]*2)] 6 ] *3 10. This does introduce a new representation in terms of the superscripted loop numbers but hopefully it makes sense. (I actually don't know why I thought the first representation was appropriate but I have left it in place as it highlights the ease of defect introduction into any human endeavor.)

Postscript: The script actually does identify 1 3 4 5 3 4 7 6 10, so it does more than link coverage and is often too enthusiastic with it's loop handling.

Related information is contained in our essay on [Structural Path Analysis](http://www.compendiumdev.co.uk/essays/pathexploration/pathanalysis.htm).