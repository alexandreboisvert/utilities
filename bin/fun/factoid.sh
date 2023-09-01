#!/usr/bin/env bash

# Inspired by https://www.reddit.com/r/AskReddit/comments/qk3hec/whats_a_cool_fact_you_think_others_should_know/.compact

factoids="Human's ability smell petrichor (smell of wet earth from rain) is greater than a Shark's ability to smell blood in water. https://en.wikipedia.org/wiki/Petrichor
That the patent for the fire hydrant was lost in a fire
Dogs that are slightly underweight live an average of two years longer than dogs that are slightly overweight.
If you find a four leaf clover then there is a good chance you'll find more not too far away.
There was a phantom poop on an Apollo mission. A poop, floating around, that none of the astronauts said was theirs.
In the pineal gland in your brain, over time it will start to form tiny calcification, little mineral buildups. There is no known function for these but scientists named it corpora arenacea also known as dream sand.
Eugene Aldrin, the father of the famous moon landing astronaut Buzz Aldrin, not only witnessed the Wright brothers' first flight but also went to see his son land on the moon in his lifespan.
Muscles do not develop the same in everyone and their exact origins/insertions can differ between people. In some the biceps have three or more heads, as opposed to the normal two. Some muscles are entirely absent, such as the psoas minor (found in about 40% of humans) and the sternalis (only 7.8%).
Butterflies and Moths can drink blood and tears in order to get nutrients. It's called Mud-puddling. I think more horror movies should use this.
They took a piece of the original Wright flyer to the moon with them on Apollo 11.
Twister was the first movie released on DVD. The Matrix was the first movie to have the DVD format outsell the VHS format.
The shell is part of the turtle's skeleton.
Komodo dragons are the largest animals in the world capable of reproducing asexually.
90% of the population on Earth lives in the Northern Hemisphere.
When a person receives a kidney transplant they don't take out the old kidneys, they just shove em to the side and leave em in there.
The Anglo-Zanzibar war. 38 minutes."

echo "${factoids}" | shuf -n1

