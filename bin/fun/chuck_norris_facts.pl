#!/usr/bin/perl -W -t -T

# Inspired by: https://chucknorrisfacts.net/

# useful commands:
# validation check
# perl -c -t -W template_boilerplate.pl
# formatting
# perltidy -b template_boilerplate.pl

# part of perlstyle: http://perldoc.perl.org/perlstyle.html
use strict;
use warnings;

# Arguments parsing
use Getopt::Long;

my @facts = (
    "Chuck Norris' tears cure cancer. Too bad he has never cried. Ever.",
    "Chuck Norris does not sleep. He waits.",
"Chuck Norris is currently suing NBC, claiming Law and Order are trademarked names for his left and right legs.",
    "The chief export of Chuck Norris is pain.",
"If you can see Chuck Norris, he can see you. If you can't see Chuck Norris, you may be only seconds away from death.",
    "Chuck Norris has counted to infinity. Twice.",
"Chuck Norris does not hunt because the word hunting implies the probability of failure. Chuck Norris goes killing.",
    "Chuck Norris doesn't wash his clothes, he disembowels them.",
"Chuck Norris is 1/8th Cherokee. This has nothing to do with ancestry, the man ate a fucking Indian.",
"In fine print on the last page of the Guinness Book of World Records it notes that all world records are held by Chuck Norris, and those listed in the book are simply the closest anyone else has ever gotten.",
    "There is no chin behind Chuck Norris' beard. There is only another fist.",
"Chuck Norris once roundhouse kicked someone so hard that his foot broke the speed of light, went back in time, and killed Amelia Earhart while she was flying over the Pacific Ocean.",
"Crop circles are Chuck Norris' way of telling the world that sometimes corn needs to lie the fuck down.",
"The Great Wall of China was originally created to keep Chuck Norris out. It failed miserably.",
"If you ask Chuck Norris what time it is, he always says, \"Two seconds 'till.\" After you ask, \"Two seconds 'til what?\" he roundhouse kicks you in the face.",
    "Chuck Norris drives an ice cream truck covered in human skulls.",
"Chuck Norris sold his soul to the devil for his rugged good looks and unparalleled martial arts ability. Shortly after the transaction was finalized, Chuck roundhouse-kicked the devil in the face and took his soul back. The devil, who appreciates irony, couldn't stay mad and admitted he should have seen it coming. They now play poker every second Wednesday of the month.",
"There is no theory of evolution, just a list of creatures Chuck Norris allows to live.",
"Chuck Norris once ate three 72 oz. steaks in one hour. He spent the first 45 minutes having sex with his waitress.",
"Chuck Norris is the only man to ever defeat a brick wall in a game of tennis.",
"Chuck Norris doesn't churn butter. He roundhouse kicks the cows and the butter comes straight out.",
"When Chuck Norris sends in his taxes, he sends blank forms and includes only a picture of himself, crouched and ready to attack. Chuck Norris has not had to pay taxes ever.",
    "The quickest way to a man's heart is with Chuck Norris' fist.",
"A Handicap parking sign does not signify that this spot is for handicapped people. It is actually in fact a warning, that the spot belongs to Chuck Norris and that you will be handicapped if you park there.",
"Chuck Norris will attain statehood in 2009. His state flower will be the Magnolia.",
"Nagasaki never had a bomb dropped on it. Chuck Norris jumped out of a plane and punched the ground.",
"Chuck Norris originally appeared in the \"Street Fighter II\" video game, but was removed by Beta Testers because every button caused him to do a roundhouse kick. When asked bout this \"glitch,\" Norris replied, \"That's no glitch.\"",
"The opening scene of the movie \"Saving Private Ryan\" is loosely based on games of dodge ball Chuck Norris played in second grade.",
"Chuck Norris once shot down a German fighter plane with his finger, by yelling, \"Bang!\"",
"Chuck Norris once bet NASA he could survive re-entry without a spacesuit. On July 19th, 1999, a naked Chuck Norris re-entered the earth's atmosphere, streaking over 14 states and reaching a temperature of 3000 degrees. An embarrassed NASA publicly claimed it was a meteor, and still owes him a beer.",
    "Chuck Norris has two speeds: Walk and Kill.",
"Someone once tried to tell Chuck Norris that roundhouse kicks aren't the best way to kick someone. This has been recorded by historians as the worst mistake anyone has ever made.",
"Contrary to popular belief, America is not a democracy, it is a Chucktatorship.",
"Teenage Mutant Ninja Turtles is based on a true story: Chuck Norris once swallowed a turtle whole, and when he crapped it out, the turtle was six feet tall and had learned karate.",
"Chuck Norris is not hung like a horse... horses are hung like Chuck Norris",
"Chuck Norris is the only human being to display the Heisenberg uncertainty principle -- you can never know both exactly where and how quickly he will roundhouse-kick you in the face.",
    "Chuck Norris can drink an entire gallon of milk in forty-seven seconds.",
    "Time waits for no man. Unless that man is Chuck Norris.",
"The Chuck Norris military unit was not used in the game Civilization 4, because a single Chuck Norris could defeat the entire combined nations of the world in one turn.",
"In an average living room there are 1,242 objects Chuck Norris could use to kill you, including the room itself.",
"Pluto is actually an orbiting group of British soldiers from the American Revolution who entered space after the Chuck gave them a roundhouse kick to the face.",
"When Chuck Norris goes to donate blood, he declines the syringe, and instead requests a hand gun and a bucket.",
    "There are no weapons of mass destruction. Just Chuck Norris.",
    "Chuck Norris sheds his skin twice a year.",
"When Chuck Norris calls 1-900 numbers, he doesn't get charged. He holds up the phone and money falls out.",
"Chuck Norris once ate a whole cake before his friends could tell him there was a stripper in it.",
"There are no races, only countries of people Chuck Norris has beaten to different shades of black and blue.",
"Chuck Norris can't finish a \"color by numbers\" because his markers are filled with the blood of his victims. Unfortunately, all blood is dark red.",
"A Chuck Norris-delivered Roundhouse Kick is the preferred method of execution in 16 states.",
"When Chuck Norris falls in water, Chuck Norris doesn't get wet. Water gets Chuck Norris.",
"Chuck Norris's urine was the main ingredient for balco's designer steroids. Therefore, Chuck Norris is actually the all-time single-season home run king.",
"Scientists have estimated that the energy given off during the Big Bang is roughly equal to 1CNRhK (Chuck Norris Roundhouse Kick)",
    "Chuck Norris' house has no doors, only walls that he walks through.",
"When Chuck Norris has sex with a man, it won't be because he is gay. It will be because he has run out of women.",
"Chuck Norris doesn't actually write books, the words assemble themselves out of fear.",
"In honor of Chuck Norris, all McDonald's in Texas have an even larger size than the super-size. When ordering, just ask to be \"Norrisized\".",
"If tapped, a Chuck Norris roundhouse kick could power the country of Australia for 44 minutes.",
"The grass is always greener on the other side, unless Chuck Norris has been there. In that case the grass is most likely soaked in blood and tears.",
"Newton's Third Law is wrong: Although it states that for each action, there is an equal and opposite reaction, there is no force equal in reaction to a Chuck Norris roundhouse kick.",
"Chuck Norris invented his own type of karate. It's called Chuck-Will-Kill.",
"When an episode of Walker Texas Ranger was aired in France, the French surrendered to Chuck Norris just to be on the safe side.",
    "While urinating, Chuck Norris is easily capable of welding titanium.",
"Chuck Norris once sued the Houghton-Mifflin textbook company when it became apparent that their account of the war of 1812 was plagiarized from his autobiography.",
"Wilt Chamberlain claims to have slept with more than 20,000 women in his lifetime. Chuck Norris calls this \"a slow Tuesday.\"",
"Contrary to popular belief, there is indeed enough Chuck Norris to go around.",
"For some, the left testicle is larger than the right one. For Chuck Norris, each testicle is larger than the other one.",
"When taking the SAT, write \"Chuck Norris\" for every answer. You will score a 1600.",
"Chuck Norris invented black. In fact, he invented the entire spectrum of visible light. Except pink. Tom Cruise invented pink.",
"When you're Chuck Norris, anything + anything is equal to 1. One roundhouse kick to the face.",
"Chuck Norris has the greatest Poker-Face of all time. He won the 1983 World Series of Poker, despite holding only a Joker, a Get out of Jail Free Monopoly card, a 2 of clubs, 7 of spades and a green #4 card from the game UNO.",
    "Chuck Norris has 12 moons. One of those moons is the Earth.",
"Chuck Norris grinds his coffee with his teeth and boils the water with his own rage.",
"Archeologists unearthed an old English dictionary dating back to the year 1236. It defined \"victim\" as \"one who has encountered Chuck Norris\"",
    "Chuck Norris ordered a Big Mac at Burger King, and got one.",
"Chuck Norris and Mr. T walked into a bar. The bar was instantly destroyed, as that level of awesome cannot be contained in one building.",
"If you Google search \"Chuck Norris getting his ass kicked\" you will generate zero results. It just doesn't happen.",
"Chuck Norris doesn't bowl strikes, he just knocks down one pin and the other nine faint.",
"The show Survivor had the original premise of putting people on an island with Chuck Norris. there were no survivors and the pilot episode tape has been burned.",
    "Chuck Norris can slam a revolving door.",
"When Chuck Norris is in a crowded area, he doesn't walk around people. He walks through them",
"James Cameron wanted Chuck Norris to play the Terminator. However, upon reflection, he realized that would have turned his movie into a documentary, so he went with Arnold Schwarzenegger.",
    "Chuck Norris can touch MC Hammer.",
    "Chuck Norris can divide by zero.",
"Chuck Norris was bitten by a cobra and after five days of excruciating pain... the cobra died.",
"He who laughs last, laughs best. He who laughs at Chuck Norris, it's definitely his last laugh.",
"The easiest way to determine Chuck Norris's age is to cut him in half and count the rings.",
    "Chuck Norris doesn't dial the wrong number. You answered the wrong phone.",
    "Chuck Norris knows Victoria's secret.",
"If Chuck Norris was a Spartan in the movie 300, the movie would be called 1.",
    "When Chuck Norris turned 18, his parents moved out.",
    "When Chuck Norris swims in the ocean, the sharks are in a steel cage.",
"Chuck Norris will never have a heart attack. His heart isn't nearly foolish enough to attack him.",
"Chuck Norris once kicked a horse in the chin. Its descendants today are known as giraffes.",
    "Chuck Norris doesn't breathe air. He holds air hostage.",
    "Chuck Norris can delete the Recycling Bin.",
"Chuck Norris has already been to Mars. That's why there are no signs of life.",
    "Chuck Norris can kill two stones with one bird.",
"Chuck Norris's calendar goes straight from March 31st to April 2. No one fools Chuck Norris.",
    "Chuck Norris wears sunglasses so that his eyes won't hurt the sun.",
"If you see Chuck Norris crying he will grant you a wish, if your wish is dying.",
    "When Chuck Norris works out he doesn't get stronger, the machine does.",
"Chuck Norris was once bitten by a cobra snake. After 3 long days of suffering, the snake died.",
    "Chuck Norris can pick up a missed call.",
    "When Chuck Norris does a pushup, he pushes the earth down.",
    "Chuck Norris' password is the last 9 digits of pi.",
    "Chuck Norris can clap with one hand.",
"Before he goes to sleep, the boogey man checks under his bed for Chuck Norris.",
"Chuck Norris does not have near death experiences, Death has near Chuck Norris experiences.",
    "Chuck Norris gets 4-wheel drive out of his bicycle.",
    "Chuck Norris doesn't mow his lawn. He dares it to grow."
);

my $print_help   = 0;
my $getoptresult = GetOptions( "help" => \$print_help, );

if ($getoptresult) {

    if ($print_help) {

        print "Print a Chuck Norris Fact\n";
        print "-h/--help: print this help and exit\n";
        exit 0;
    }

    my $fact_index = int( rand( scalar(@facts) ) );
    print $facts[$fact_index] . "\n";
}
else {

    print "Getopt failed\n";
}

exit 0;
