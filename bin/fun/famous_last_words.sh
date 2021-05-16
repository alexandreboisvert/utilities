#!/usr/bin/env bash

# Inspired by: https://www.reddit.com/r/AskReddit/comments/n917rz/apart_from_life_is_short_what_other_lines_do_you/.compact

last_words="Life is short.
Not all decisions i make will be right and this one will be no exception.
What's the worst that could happen?
That's for future me to worry about.
Why not?
FUCK IT WE'RE DOING IT LIVE!
It won't be that bad, right?
I wanna sound cool for my grandkids.
In for a penny, in for a pound.
Might as well see where this goes.
What could possibly go wrong?
If anything goes sideways, [insert friends name here] can help me.
Hold my beer.
I'll be fine.
Leeeerooyyy...JENNNNNNKINNNNNNNSSS!
I don't care anymore.
Whatever.
Is this a bad decision? Probably. Will I go ahead with it? Absolutely!
C'est la vie.
I'm just gonna wing it!
God hates a coward.
I'm here for a good time, not a long time.
I will go with my gut.
I'll figure it out later.
Not like I'm gonna make it out of life alive anyways"

echo "${last_words}" | shuf -n1
