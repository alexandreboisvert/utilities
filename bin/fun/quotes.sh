#!/usr/bin/env bash

# Quotes I found on the net
# Quotes I heard
# Quotes I learned the hard way

quotes="Change is a door that can only be opened from the inside.
Do you have 25 years of experience or do you have 25 times the same year of experience.
Eat the elephant one bite at a time.
If you fight every battle to the death, you won't be around to win the war.
Drain the swamp, and the stumps appear.
Detached involvement is the essence of leadership.
Are you successful or a success fool?
When a problem occurs at level N, the solution usually comes from level N-1 or N+1.
The only person who truly welcomes a change is a baby with a full diaper.
Never underestimate the power of human stupidity -- Robert A. Heinlein -- Writer -- 1907/1988
Democracy is a process by which the people are free to choose the man who will get the blame. -- Laurence J. Peter (1919 - 1988)
To err is human, but to really foul things up requires a computer. -- Farmers' Almanac -- 1978
The thing that impresses me the most about America is the way parents obey their children. -- King Edward VIII (1894 - 1972)
The trouble with the rat race is that even if you win, you're still a rat. -- Lily Tomlin (1939 - )
It is difficult to produce a television documentary that is both incisive and probing when every twelve minutes one is interrupted by twelve dancing rabbits singing about toilet paper. -- Rod Serling -- (1924 - 1975)
My Grandmother is over eighty and still doesn't need glasses. Drinks right out of the bottle. -- Henny Youngman (1906 - 1998)
Politics is the art of preventing people from taking part in affairs which properly concern them. -- Paul Valery (1871 - 1945)
Politics is not a bad profession. If you succeed there are many rewards, if you disgrace yourself you can always write a book. -- Ronald Reagan (1911 - )
Politics is the skilled use of blunt objects. -- Lester B. Pearson (1897 - 1972)
Canada is a country whose main exports are hockey players and cold fronts. Our main imports are baseball players and acid rain. -- Pierre Trudeau (1919 - 2000)
Everyone has a purpose in life. Perhaps yours is watching television. -- David Letterman (1947 - )
One of the penalties for refusing to participate in politics is that you end up being governed by your inferiors. -- Plato (427 BC - 347 BC)
Canadians have an abiding interest in surprising those Americans who have historically made little effort to learn about their neighbour to the North. -- Peter Jennings
Anyone who is capable of getting themselves made President should on no account be allowed to do the job. -- Douglas Adams (1952 - 2001)
In C, you merely shoot yourself in the foot. In C++, you accidentally create a dozen instances of yourself and shoot them all in the foot. Providing emergency medical care is impossible, because you can't tell which are bitwise copies and which are just pointing at others and saying, That's me, over there.
Management is doing things right; leadership is doing the right things. -- Peter Drucker
Cover your ass. Get everything in writing. If you have a verbal conversation, follow it up with an e-mail. Remember... shit flows downhill. They WILL try to find a way to shift the blame. Make sure you do not become the scapegoat.
Who says Nothing is impossible? I do Nothing.
I can solve differential equations and build huge databases, but I have no idea how to change my oil.
Nobody believes the official spokesman, but everybody trusts an unidentified source.
Wikipedia, cheaper than college!
Work is the greatest thing in the world, so we should always save some of it for tomorrow. -- Don Herold
the loudest sound is the last heartbeat -- max headroom
Release early, release often. Don't worry, be crappy. Fail fast. Iterate.
The wider the smile, the bigger the lies.
The future is already here - it's just not very evenly distributed. -- William Gibson
We're just a Google outage away from an IT shortage.
Never spend 6 minutes doing something by hand when you can spend 6 hours failing to automate it.
Provocative maintenance - when the preventative maintenance causes the very outage you were trying to avoid.
Percussive maintenance: smacking the side of the PC to get it to work.
The S in IoT stands for Security.
We'll cross that bridge when it's on fire.
We'll burn that bridge when we get to it.
If it's critical, there's a backup of it. That includes the staff
This is just a temporary fix. There's nothing as permanent as a temporary solution.
It's a layer-8 issue
Fast, Cheap, Good. You can only pick two.
Everyone has a test environment. A few of us are lucky enough to also have production environments.
There's no test like Production.
We fix problems you didn't know you had in ways you wouldn't understand.
Equipment that can't perform up to specs is replaced. Equipment that won't perform up to specs is abused until it will, or it can't.
DevOops
a failure to plan on your part does not equate an emergency on my part
A fool with a tool is still a fool.
Never get good at something you don't want to do for a living. Or if you do, don't let anybody know about it!
If you're not testing restores, you're not taking backups.
RTFM - read the fucking manual
Just 'coz you can, don't mean you should.
Fuck it! We're doing it live!
No good deed goes unpunished.
Not my circus. Not my monkeys.
Was the problem caused by hardware or software? Neither, it was the meatware.
Code18, Issue is 18 inches away from the monitor
You don't trip over boulders, but pebbles will fucking kill you.
Linux is only free if you don't consider your time valuable...
I don't always test my code, but I do, its in production.
Technical Debt - pay for it now or pay a lot more later
It's not a bug, it's a feature.
"

echo "${quotes}" | shuf -n1
