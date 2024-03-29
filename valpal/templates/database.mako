<%inherit file="home_comp.mako"/>
<%namespace name="util" file="util.mako"/>

<h2>Database Questionnaire Manual</h2>

<div id="database-page">

<div id="database-toc" class="well well-small">
  <strong>ToC</strong>
  <ul>
    <li><a href="#goals">1. Goals and motivations</a></li>
    <li><a href="#contributions">2. Project contributions</a></li>
    <li><a href="#verb_meanings">3. The verb meanings</a></li>
    <li><a href="#tasks">4. Tasks for the database contributors</a></li>
    <li><a href="#counterpart_verbs">5. Counterpart verbs</a></li>
    <li><a href="#examples">6. Examples</a></li>
    <li><a href="#coding_frames">7. Coding frames</a></li>
    <li><a href="#valency_alternations">8. Valency alternations</a></li>
    <li><a href="#optional_advanced_features">9. Optional advanced features</a></li>
  </ul>
</div>

<p>
  → <a href="${request.static_url('valpal:static/ValencyDBQuestionnaireManual.pdf')}">Download manual as PDF</a>
</p>

<div id="database-intro" class="alert alert-block">
<p>
The following manual describes the guidelines that the editors asked the
database contributors to follow in filling in the questionnaire.  It defines all
the key concepts, discusses a number of potential issues, and gives some
examples.
</p>
</div>

<h3 id="goals">1. Goals and motivations</h3>

<p>
The Leipzig Valency Classes Project (funded by the DFG) is carrying out
a large-scale cross-linguistic comparison of valency classes (or "verb types",
in terms of Levin 1993).  With respect to their valency properties, verbs fall
into different classes in all languages.  The project is inspired by Levin
(1993), a classical study of syntactic classes of verbs in English, which shows
that a semantic classification of verbs can be achieved through applying
syntactic diagnostics.  Yet, this study, as well as an earlier study by Apresjan
(1967) on Russian, has not been followed up cross-linguistically, which leaves
open the question of which aspects of these classifications are universal and
which are language-particular.  Similarly, valency dictionaries are few in
number and mostly deal with European languages, thus they cannot fill the gap.
</p>

<p class="toplink">↑ <a href="#">top</a></p><hr>
<h3 id="contributions">2. Project contributions</h3>

<p>
To make progress in the cross-linguistic study of valency classes, the members
of the Valency Classes Project (Andrej Malchukov, Martin Haspelmath, Bernard
Comrie, Iren Hartmann) have assembled a group of contributors, specialists of
valency patterns in a representative set of languages, who are collaborating to
obtain a consistent set of cross-linguistic data.  The contributors have been
asked to do three things as part of their contribution  to the project:
</p>

<ol id="database-contribs">
  <li>
    fill in the <strong>database questionnaire</strong>, which (minimally) asks
    for valency information on a set of 70 verb meanings (taken as
    representative of the verbal lexicon) for each project language; individual
    databases will be published as part of an online database (edited by Iren
    Hartmann and Martin Haspelmath)
  </li>
  <li>
    give a presentation on language-particular patterns at the <strong>Leipzig
    Valency Classes Conference</strong> (2011 April 14–17)
  </li>
  <li>
    contribute a paper to an edited volume on valency classes
    cross-linguistically (edited by Andrej Malchukov and Bernard Comrie)
  </li>
</ol>

<p>
In the following, the database questionnaire is described.  (Items (ii) and
(iii) are described elsewhere.)
</p>

<p class="toplink">↑ <a href="#">top</a></p><hr>
<h3 id="verb_meanings">3. The verb meanings</h3>

<p>
The purpose of the Valency Database Questionnaire is to gather comparable
valency data on a wide variety of languages.  The data will be comparable
because the verbs are elicited in response to a list of 70 pre-defined verb
meanings, and because the valency information is recorded in a standard way.
The 70 verb meanings are described in Table 1, in three columns: (i) the meaning
label, (ii) the role frame, and (iii) a typical context.  (Since the English
verbs used as meaning labels sometimes have different meanings, we have added
a sentence for each verb meaning that makes the intended meaning clear.  These
sentences are not crucial, they are just intended to help the contributors find
a context for a counterpart.)
</p>

<p><strong>Table 1: The 70 verb meanings</strong></p>

<table class="table table-bordered table-striped" style="width:auto">
  <thead>
    <tr>
      <th>meaning label</th>
      <th>role frame</th>
      <th>typical context</th>
    </tr>
  </thead>
  <tbody>
    <tr><td>RAIN</td><td>(it) rains</td><td>It rained yesterday.</td></tr>
    <tr><td>BE DRY</td><td>S is dry</td><td>The ground is dry.</td></tr>
    <tr><td>BURN</td><td>S burns</td><td>The house is burning.</td></tr>
    <tr><td>SINK</td><td>S sinks</td><td>The boat sank.</td></tr>
    <tr><td>ROLL</td><td>A rolls</td><td>The ball is rolling.</td></tr>
    <tr><td>BE A HUNTER</td><td>S is a hunter</td><td>This man is a hunter.</td></tr>
    <tr><td>BE HUNGRY</td><td>E is hungry</td><td>The baby is hungry.</td></tr>
    <tr><td>BE SAD</td><td>E is sad</td><td>The little girl was sad.</td></tr>
    <tr><td>DIE</td><td>S dies</td><td>The snake died.</td></tr>
    <tr><td>FEEL COLD</td><td>S is cold</td><td>I’m cold.</td></tr>
    <tr><td>FEEL PAIN</td><td>E feels pain in M</td><td>My arm is hurting. = I’m feeling pain in my arm.</td></tr>
    <tr><td>SCREAM</td><td>S screams</td><td>The man screamed.</td></tr>
    <tr><td>LAUGH</td><td>S laughs</td><td>The little girl laughed.</td></tr>
    <tr><td>PLAY</td><td>S plays</td><td>The child is playing.</td></tr>
    <tr><td>LIVE</td><td>S lives somewhere (L)</td><td>The old people live in town.</td></tr>
    <tr><td>LEAVE</td><td>A left L</td><td>The boy left the village.</td></tr>
    <tr><td>GO</td><td>S goes somewhere (L)</td><td>The woman went to the market.</td></tr>
    <tr><td>SING</td><td>S sings</td><td>The boy sang (a song).</td></tr>
    <tr><td>JUMP</td><td>A jumps</td><td>The girl jumped.</td></tr>
    <tr><td>SIT DOWN</td><td>S sits down (somewhere (L))</td><td>The children sat down on the bench.</td></tr>
    <tr><td>SIT</td><td>S sits somewhere (L)</td><td>The children sat on the floor.</td></tr>
    <tr><td>RUN</td><td>A runs</td><td>The horse is running.</td></tr>
    <tr><td>CLIMB</td><td>A climbs (up L)</td><td>The men climbed (up) the tree.</td></tr>
    <tr><td>COUGH</td><td>S coughs</td><td>The old man coughed.</td></tr>
    <tr><td>BLINK</td><td>S blinks</td><td>I blinked (my eyes).</td></tr>
    <tr><td>SHAVE</td><td>A shaves (his beard/hair)</td><td>The man shaved his beard/cut his hair</td></tr>
    <tr><td>DRESS</td><td>A dresses P</td><td>The mother dressed her daughter</td></tr>
    <tr><td>WASH</td><td>A washes P</td><td>The mother washed the baby.</td></tr>
    <tr><td>EAT</td><td>A eats P</td><td>The boy ate the fruit.</td></tr>
    <tr><td>HELP</td><td>A helps X</td><td>I helped the boys.</td></tr>
    <tr><td>FOLLOW</td><td>A follows X</td><td>The boys followed the girls.</td></tr>
    <tr><td>MEET</td><td>A meets X</td><td>The men met the boys.</td></tr>
    <tr><td>HUG</td><td>A hugs P</td><td>The mother hugged her little boy.</td></tr>
    <tr><td>SEARCH FOR</td><td>A searches for X</td><td>The men searched for the women.</td></tr>
    <tr><td>THINK</td><td>A thinks about X</td><td>The girl thought about her grandmother yesterday.</td></tr>
    <tr><td>KNOW</td><td>A knows P</td><td>The girl knew the boy.</td></tr>
    <tr><td>LIKE</td><td>E likes M</td><td>The boy liked his new toy.</td></tr>
    <tr><td>FEAR</td><td>E fears M</td><td>The man feared the bear.</td></tr>
    <tr><td>FRIGHTEN</td><td>A frightens P</td><td>The bear frightened the man.</td></tr>
    <tr><td>SMELL</td><td>E smells M</td><td>The bear smelled the boy.</td></tr>
    <tr><td>LOOK AT</td><td>A looks at P</td><td>The boy looked at the girl.</td></tr>
    <tr><td>SEE</td><td>E sees M</td><td>The man saw the bear.</td></tr>
    <tr><td>TALK</td><td>A talks (to X) (about Y)</td><td>The girl talked to the boy about her dog.</td></tr>
    <tr><td>ASK FOR</td><td>A asks (X) for Y</td><td>The boy asked his parents for money.</td></tr>
    <tr><td>SHOUT AT</td><td>A shouts at X</td><td>The woman shouted at the children.</td></tr>
    <tr><td>TELL</td><td>A tells (X) Y</td><td>The girl told the boy a funny story.</td></tr>
    <tr><td>SAY</td><td>A says “...”( to X)</td><td>They said “no” to me.</td></tr>
    <tr><td>NAME</td><td>A name X (a) Y</td><td>The parents called the baby Anna.</td></tr>
    <tr><td>BUILD</td><td>A builds P (out of X)</td><td>The men built a house out of wood.</td></tr>
    <tr><td>BREAK</td><td>A breaks P (with I)</td><td>The boy broke the window with a stone.</td></tr>
    <tr><td>KILL</td><td>A kills P (with I)</td><td>The man killed his enemy with a club.</td></tr>
    <tr><td>BEAT</td><td>A beats P (with I)</td><td>The boy beat the snake with a stick.</td></tr>
    <tr><td>HIT</td><td>A hits P (with I)</td><td>The boy hit the snake with a stick.</td></tr>
    <tr><td>TOUCH</td><td>A touches P (with I)</td><td>The boy touched the snake with a stick.</td></tr>
    <tr><td>CUT</td><td>A cuts P (with I)</td><td>The woman cut the bread with a sharp knife.</td></tr>
    <tr><td>TAKE</td><td>A takes P (from X)</td><td>The man took the money from his friend.</td></tr>
    <tr><td>TEAR</td><td>A tears P (from X)</td><td>The girl tore the page from the book.</td></tr>
    <tr><td>PEEL</td><td>A peels (X off) P</td><td>The boy peeled the bark off the stick.</td></tr>
    <tr><td>HIDE</td><td>A hides T (from X)</td><td>The boy hid the frog from his mother.</td></tr>
    <tr><td>SHOW</td><td>A shows T (to R)</td><td>The girls showed pictures to the teacher.</td></tr>
    <tr><td>GIVE</td><td>A gives T to R</td><td>We gave the books to the children.</td></tr>
    <tr><td>SEND</td><td>A sends T (to X)</td><td>The girl sent flowers to her grandmother.</td></tr>
    <tr><td>CARRY</td><td>A carries T (to X)</td><td>The men carried the boxes to the market.</td></tr>
    <tr><td>THROW</td><td>A throws T somewhere (L)</td><td>The boy threw the ball into the window.</td></tr>
    <tr><td>TIE</td><td>A ties P (to L) (with I)</td><td>The man tied the horse with a rope to the tree.</td></tr>
    <tr><td>PUT</td><td>A puts T somewhere (L)</td><td>I put the cup onto the table.</td></tr>
    <tr><td>POUR</td><td>A pours T somewhere (L)</td><td>The man poured water into the glass.</td></tr>
    <tr><td>COVER</td><td>A covers P (with X)</td><td>The woman covered the boy with a blanket.</td></tr>
    <tr><td>FILL</td><td>A fills P (with X)</td><td>The girl filled the glass with water.</td></tr>
    <tr><td>LOAD</td><td>A loads T (onto L)</td><td>The farmer loaded hay onto the truck. = The farmer loaded the truck with hay.</td></tr>
  </tbody>
</table>

<p>
This sample of 70 verbs<a href="#ftn1"><sup>1</sup></a>, which was in part
selected on the basis of the feedback from the
contributors<a href="#ftn2"><sup>2</sup></a>, is hoped to be representative of
the verbal lexicon. It is in particular these verb meanings that have been
reported to show distinctive grammatical behaviour in the literature. Of course
the editors had to try to strike a balance between a temptation to include more
interesting verb meanings in the list, and avoiding overload on the part of
contributors if confronted with a more extensive list. Further interesting verbs
could be added to the database of individual languages (see §9.2).
</p>

<p class="toplink">↑ <a href="#">top</a></p><hr>
<h3 id="tasks">4. Tasks for the database contributors</h3>

<p>
Contributors are asked to provide four types of information, in four different
tables of the database:
</p>

<ol>
  <li>counterpart verbs, in the Verbs table (§5)</li>
  <li>examples, in the Examples table (§6)</li>
  <li>coding frames, in the Coding frames table (of these verbs) (§7)</li>
  <li>valency alternations (undergone by these verbs), in the Alternations table (§8)</li>
</ol>

<p class="toplink">↑ <a href="#">top</a></p><hr>
<h3 id="counterpart_verbs">5. Counterpart verbs</h3>

<p>
Please find a counterpart verb in your language for each of the pre-defined verb
meanings. Note that the meaning definition is given by the role frame (plus
optional comments in the meaning comments field, and example), not by the
meaning label (COVER, FILL, etc.). The latter is only a label that serves as
a heading for the record. The meaning thus includes information about semantic
roles, for which the role frame is crucial (e.g. the meaning intended by WASH is
'A washes P', not 'A washes').
</p>

<p>
For each verb meaning of the database, please find the semantically most fitting
non-derived verb in the project language. More generally, the verb should have
a "basic" flavour, i.e. verbs that are used very rarely should be avoided if
a more commonly verb with similar meaning is available. “Basic”ness of the
counterpart verbs is more important than exact semantic equivalence between the
pre-defined meanings and the counterparts. The only requirement is that the
correspondence is close enough to be helpful for the project.
</p>

<p>
The relationship between pre-defined meanings and counterpart verbs is many to
many. This means that if there are two basic verbs in your language that
correspond to a meaning, you should include them both, and if a single verb
corresponds to two different meanings, it needs to be given only once.
</p>

<p>
If there is no counterpart in your language and a paraphrase would have to be
used (e.g. if HIDE is expressed as 'put something somewhere where others cannot
see it'), please do not give a counterpart. (This means checking the field "No
counterpart" in the Meanings layout.)
</p>

<p>
This does not mean that verbs that are complex in some way should be excluded.
If a complex verbal expression, whether a morphologically derived form or
a syntactic phrase, is conventional (or lexicalized), it should be included,
even if it is productively derived.<a href="#ftn3"><sup>3</sup></a> Thus,
complex precicates like English <em>carry out</em> or German
<em>teil-nehmen</em> 'take part', as well as serial-verb complexes like Yoruba
<em>bá ... wí</em> 'rebuke', should be regarded as single verbs.
</p>

<p>
If a verb has other meanings than the pre-defined meaning for which it is
a counterpart, it is helpful to include these other meanings, in the comments
field.<a href="#ftn4"><sup>4</sup></a> (It is also possible to create new
meanings; see §9.3 below for this advanced feature.)
</p>

<p>
Homonymous verbs should be distinguished by a number,
e.g. <strong><em>lie (1)</em></strong> ('be in a horizontal position')
and <strong><em>lie (2)</em></strong> ('say something that is untrue').
</p>

<p>
The "comments" field can contain further non-structured information about all
aspects of the verb and its relationship to the pre-defined meaning.
</p>

<div class="well well-small database-infobox">
  <p>DATABASE FIELDS:</p>
  <dl>
    <dt>Verb form:</dt>
    <dd>Please give the verb in its usual citation form.</dd>
    <dt>Comments:</dt>
    <dd>You may comment on any aspect of this verb.</dd>
  </dl>
  <p>relationships:</p>
  <dl>
    <dt>Meanings:</dt>
    <dd>A verb may be related to one or more meanings from the Meanings table.</dd>
    <dt>Coding frames:</dt>
    <dd>A coding frame needs to be entered (selected or newly created) for each verb.</dd>
    <dt>Alternation values:</dt>
    <dd>The alternation values (occurs regularly, occurs marginally, occurs never, no data) are best entered on the Verbs layout.</dd>
    <dt>Examples:</dt>
    <dd>An example (with the basic coding frame) needs to be entered (generally newly created) for each counterpart verb.</dd>
    <dt>Alternation examples:</dt>
    <dd>At least one example needs to be entered (generally newly created) for each alternation. This can be done on the Verbs layout, or on the Alternation values layout.</dd>
  </dl>
</div>

<p class="toplink">↑ <a href="#">top</a></p><hr>
<h3 id="examples">6. Examples</h3>

<p>
Please provide glossed examples of sentences illustrating the coding frames and
alternations.  There should be (at least) one example for each of the
counterpart verbs with the basic coding frame, as well as (at least) one example
of each of the alternations (with some verb).<a href="#ftn5"><sup>5</sup></a>
</p>

<p>
Ideally there would also be an example of each possible verb-alternation pair
(where the verb should be shown in the non-basic alternant form). However, since
some alternations are very productive and occur with a large number of verbs,
this would be too much work for most contributors, so a complete set of
verb-alternation pair examples is not required.
</p>

<div class="well well-small database-infobox">
  <p>DATABES FIELDS:</p>
  <dl>
  <dt>Primary text:</dt>
  <dd>Please give the example text in the way the language is normally written by linguists.</dd>
  <dt>Original orthography:</dt>
  <dd>Give the original orthography, if it differs from the way linguists write the language (e.g. if it is in a different script).</dd>
  <dt>Analyzed text:</dt>
  <dd>This field is for text with hyphenation or other annotation, if required for morpheme-by-morpheme glosses.</dd>
  <dt>Gloss:</dt>
  <dd>Morpheme-by-morpheme gloss, following the Leipzig Glossing Rules.</dd>
  <dt>Translation:</dt>
  <dd>Idiomatic translation into English.</dd>
  <dt>Other translation:</dt>
  <dd>Idiomatic translation into a major language other than English.</dd>
  <dt>Comments:</dt>
  <dd>Any kind of comments on the example.</dd>
  <dt>Example type:</dt>
  <dd>Select one example type from the list (elicited from speaker, naturalistic spoken, naturalistic written, constructed by linguist, constructed by native speaker linguist, other).</dd>
  </dl>
  <p>relationships:</p>
  <dl>
  <dt>Source person:</dt>
  <dd>Give the name of the source person if the example was elicited or constructed.</dd>
  <dt>Reference:</dt>
  <dd>Include a reference if the example is naturalistic (written or spoken)</dd>
  <dt>Pages:</dt>
  <dd>Page number of reference</dd>
  </dl>
</div>

<p class="toplink">↑ <a href="#">top</a></p><hr>
<h3 id="coding_frames">7. Coding frames</h3>

<h4>7.1. Defining valency</h4>

<p>
In our terminology, the <strong>valency</strong> of a verb is the list of its
<strong>arguments</strong> with their coding properties
(<strong>coding frame</strong>), their behavioural properties
(<strong>syntactic-function frame</strong>), and with the relationship of the
arguments to the roles in the verb's <strong>role frame</strong>.
</p>

<p>
Coding properties involve the following techniques (Haspelmath 2005; Malchukov,
Haspelmath &amp; Comrie 2010):
</p>

<ul>
  <li><strong>flagging</strong> (case or adposition marking)</li>
  <li><strong>indexing</strong> (agreement, cross-referencing)</li>
  <li><strong>word order</strong> (in the absence of other kinds of marking)</li>
</ul>

<p>
Behavioural properties concern the behaviour with respect to patterns like
reflexivization, passivization, causativization, argument omission, and various
cross-clausal constructions such as control, switch-reference, raising and
coordination. As a verb's valency consists of both the coding properties and the
behavioural properties of its arguments, all these are in principle relevant to
valency. However, in the Leipzig Valency Classes Project, only coding properties
and one aspect of the behavioural properties, alternations, are taken into
account.
</p>

<p>
An example of a full specification of a verb's valency is given below for
English <em>remind</em>:
</p>

<p>English <em>remind</em></p>

<table class="table table-bordered" style="width:auto">
  <tr>
    <td>coding frame:</td>
    <td><strong>A &gt; V.subj[A] &gt; R &gt; of+T</strong></td>
  </tr>
  <tr>
    <td>syntactic-function frame:</td>
    <td>subject<sub>X</sub> direct.object<sub>Y</sub> oblique.object<sub>Z</sub></td>
  </tr>
  <tr>
  <td>role frame:</td>
  <td>
      <strong>A reminds R of T</strong>
      (or: agent<sub>A</sub> addressee<sub>R</sub> theme<sub>T</sub>
      <br>or: A cause (remember R T))
  </td>
  <td></td>
  </tr>
  <tr>
  </tr>
</table>

<ul>
  <li>
    The <strong>coding frame</strong> contains information about flagging (e.g.
    the preposition <em>of</em>), indexing (e.g. the fact that the verb agrees
    with the subject), and word order.
  </li>
  <li>
    The <strong>syntactic-function frame</strong> contains information about
    behavioural properties, summed up in syntactic-function labels (thus,
    "subject" means that the argument controls verb-indexing, can undergo
    raising, becomes the oblique agent in passivization, etc.). Although it is
    part of valency,
    <u>the syntactic-function frame as such plays no role in this project</u>,
    and we limit ourselves to considering the behaviour of verbs in alternations.
  </li>
  <li>
    The <strong>role frame</strong> tells us how the syntactic arguments map
    onto semantic roles (this can be done in various ways, by simple English
    glosses with participant variables, by informative semantic-role labels, or
    by semantic decomposition with participant variables).
  </li>
</ul>

<p>
An <strong>argument</strong> of a verb is a phrase whose occurrence is made
possible by a specific verb, and which therefore cannot occur with a generic
verb. This can be tested by attempting to move a phrase into a neighboring
clause with an anaphoric verb, as shown in (1a, 1c). Adjuncts, by contrast, are
not tied to particular verbs and can therefore be moved out into a clause with
an anaphoric verb (1b, 1d):
</p>

<p>(1)</p>

<ol class="datatable-ex">
  <li><em>I wrote a letter.</em> &gt; *<em>I wrote, and I did a letter.</em></li>
  <li><em>I wrote with a pen.</em> &gt; <em>I wrote, and I did it with a pen.</em></li>
  <li>
    <em>I put the book on the table.</em><br>
    *<em>I put the book, and this happened on the table.</em>
  </li>
  <li>
    I <em>wrote the letter on the table.</em> &gt;<br>
    <em>I wrote the letter, and this happened on the table.</em>
  </li>
</ol>

<p>If you are unsure whether a participant is an argument or an adjunct, please
make an arbitrary choice and include a comment in the verb layout's comment
field. (Please do not use language-specific criteria for "argumenthood", because
these are really criteria for different concepts labeled "argument", not for
comparable 'argument' concepts.)</p>

<p class="toplink">↑ <a href="#">top</a></p><hr>
<h4>7.2. Representing</h4>

<p>
Different verbs have different coding frames, but in all languages, coding
frames recur, e.g. in German, the sample coding frames shown in (2a-c) occur in
many different verbs:
</p>

<p>(2)</p>

<ol class="datatable-ex">
  <li><strong>A-nom X-dat</strong>:<br>
  (<em>helfen</em> 'A helps X', <em>folgen</em> 'A follows X', <em>dienen</em> 'A serves X', ...)</li>
  <li><strong>S-nom an+X</strong>:<br>
  (<em>denken</em> 'S thinks of X', <em>liegen</em> 'S is due to X', etc.)</li>
  <li><strong>A-nom R-acc an+T</strong>:<br>
  (<em>erinnern</em> 'A reminds R of T', etc.)</li>
</ol>

<p>
(Note: capital letters other than V are used as argument/participant
variables.<a href="#ftn6"><sup>6</sup></a>)
</p>

<p>
Since coding frames are not unique, but recur, they are in a separate table of
the database. Once a coding frame has been set up for a verb, all other verbs
using the same coding frame can make use of the same record, i.e. coding frames
need to be entered only once and can thereafter be simply selected from the list
of existing coding frames.
</p>

<p>
A coding frame is a list of all the argument variables with their standard
coding, i.e. flagging (case-marking or adposition marking), indexing
("agreement" or "cross-referencing"), possibly word order, plus a verb
variable.
</p>

<p>The following conventions are used:</p>

<ul>
  <li>
    cases: case labels are attached to an argument variable by a hyphen, e.g.
    <strong>A-nom</strong> (for nominative case), <strong>R-dat</strong>,
    <strong>P-abs</strong>
  </li>
  <li>
    adpositions: forms of adpositions are attached to an argument variable by
    a plus sign, e.g. <strong><em>for</em>+X</strong>,
    <strong><em>à</em>+R</strong>
  </li>
  <li>
    indices: index labels are attached to the verb variable by a period, e.g.
    <strong>V.subj[A]</strong> (for German subject agreement),
    <strong>subj[A].obj[P].V</strong> (for Bantu subject and object agreement);
    the role information is given in brackets noun incorporation: is marked by
    angle brackets, e.g. A P &lt;I&gt;V
  </li>
  <li>
    word order: if the order of elements is fairly fixed and potentially
    distinctive,<a href="#ftn7"><sup>7</sup></a> an greater-than character
    (&gt;) is used between elements that occur adjacent and normally in the
    given order (e.g. English <strong>A &gt; V.subj[A] &gt; P</strong>)
  </li>
  <li>
    optionality: If a coding element occurs optionally or variably (i.e. only
    under some circumstances), it can be put in
    parentheses<a href="#ftn8"><sup>8</sup></a>
  </li>
</ul>

<p>
Note that case labels and index labels are language-specific entities, just like
adpositions. There is no need to standardize (or abbreviate) them, because they
will eventually have to be defined in full detail anyway (but not within our
database). Transparent labels are good for mnemonic reasons, though. If word
order is not consistent or particularly distinctive, the order in which the
argument variables and the verb variable occur in the coding frame is in
principle arbitrary, but for mnemonic reasons, an order that corresponds to the
most frequent clause order is advisable.
</p>

<p>
It is important to note that the coding frame descriptions are necessarily
schematic and partial and cannot possibly describe the coding fully. For
example, if an index can either be a prefix or a suffix, then a salient or
dominant position should be chosen, without worrying about the incompleteness of
the coding frame. Another example is word order, which often obeys complex
regularities that cannot possibly be captured by simple schemas.
</p>

<p>
In most cases, arguments are noun phrases or adpositional phrases with specific
coding. However, arguments may also be adverbial arguments, in particular
<strong>locational arguments</strong>. These arguments do not have any specific
coding, cf. (3). In such cases, all we can say is that the argument is
a locational phrase of some sort, and the coding frame is "A V T LOC".
</p>

<p>(3)</p>

<ol class="datatable-ex">
  <li>Put the book <em>on the shelf</em></li>
  <li>Put the money <em>under the mattress</em></li>
  <li>Put it <em>here</em></li>
</ol>

<p>
Whether the arguments are obligatory or optional is not recorded in the coding
frames, because it may depend on too many different factors, most of which have
nothing to do with the verb-specific coding. If an argument can be omitted only
with certain verbs, then this should be regarded as an argument-omission
alternation (e.g. object omission with existenitial/generic meaning that is
possible for objects of certain verbs in English:
<em>He often reads/eats/drinks</em>).
</p>

<p>
If a verb is associated with several different coding frames that are not
related by a regular alternation, then the verb has to be split up (somewhat
artificially) into two different homonymous verbs. (In reality, the relationship
between verbs and coding frames is many-to-many, but we simplify our database
structure by pretending that it is many-to-one.)
</p>

<p>
The contributors indicate the semantic roles of the arguments by using the same
variables as argument variables that are used as participant variables in the
role frames of the pre-defined meanings, for instance:
</p>

<table class="table table-bordered" style="width:auto">
  <tr><td>pre-defined meaning label:</td><td>ASK FOR</td></tr>
  <tr><td>pre-defined role frame:</td><td>'A asks R for T'</td></tr>
  <tr><td>German counterpart verb:</td><td><em>bitten</em></td></tr>
  <tr><td>coding frame:</td><td><strong>A-nom V R-acc <em>um</em>+T</strong></td></tr>
</table>

<p>
In this way, it becomes clear that the nominative argument has the asker role,
the accusative argument has the askee role, and the complement of the
preposition um has the role of thing asked for.
</p>

<p>
It is important to be aware that the semantic roles in the role frames do not
necessarily correspond to syntactic arguments in your language. (The role frames
are not "semantic valency frames", and we do not work with a semantic definition
of arguments.) The role frames are intended to convey the verb's meaning and to
provide readily identifiable participant variables, not to prejudge the number
of syntactic arguments that a counterpart verb will have.
</p>

<p>
Note that in the role frames, some arguments are given in parentheses. This has
no particular meaning, but is intended to draw attention to the fact that we do
not expect all roles to correspond to arguments of the counterpart verb of your
language. The roles in parentheses seem to us particularly likely not to
correspond to arguments, but this is just an expectation based on our
impressions. What counts are the facts of your language.
</p>

<p>
If your verb is associated with two coding frames that are related via an
uncoded alternation (e.g. English <em>give</em>, which can have the coding frame
"A &gt; V &gt; R &gt; T" or the coding frame
"A &gt; V &gt; T &gt; <em>to</em>+R"), the decision of which coding frame to
take as basic may not be possible on a principled basis, so an arbitrary
decision may have to be taken.<a href="#ftn9"><sup>9</sup></a>
</p>

<p>
If your verb has an argument with a semantic role that is not included in the
role frame, please use additional role variables and characterize the additional
roles in the comment field of the coding verb.
</p>

<div class="well well-small database-infobox">
  <p>DATABASE FIELDS:</p>
  <dl>
    <dt>Coding frame schema:</dt>
    <dd>Please give the coding frame in schematic form as explained above</dd>
    <dt>Description:</dt>
    <dd>Here you should give more details of the coding frame.</dd>
    <dt>Comments:</dt>
    <dd>This field is for any further comments.</dd>
    <dt>Coding-frame class:</dt>
    <dd>See under §9.4.</dd>
  </dl>
</div>

<p class="toplink">↑ <a href="#">top</a></p><hr>
<h3 id="valency_alternations">8. Valency alternations</h3>

<h4>8.1. Defining alternations</h4>

<p>
For the purposes of our project, a <strong>valency alternation</strong> is
defined as a set of two different coding frames that are productively (or at
least regularly) associated with both members of a set of verb pairs sharing the
same verb stem. (Thus, we are restricting ourselves to coding alternations.)
Valency alternations may or may not be coded in the verb form, and accordingly
we distinguish two types of alternations, <strong>uncoded alternations</strong>
(such as the English Dative Shift alternation) and
<strong>coded alternations</strong> (such as the English Passive alternation).
</p>

<p>Examples of alternations are the following:</p>

<table id="database-alternations" class="unstyled">
  <tr><td>English:</td><td colspan="3">Dative Shift (uncoded)</td></tr>
  <tr><td></td><td><strong>A &gt; V &gt; R &gt; T</strong></td><td>&lt;&gt; </td><td><strong>A &gt; V &gt; T &gt; <em>to</em>+R</strong></td></tr>
  <tr><td></td><td></td><td colspan="2">(e.g. <em>give</em>, <em>sell</em>, <em>lend</em>, ...)</td></tr>
  <tr></tr>
  <tr><td>Russian:</td><td colspan="3">Anticausative alternation (coded)</td></tr>
  <tr><td></td><td><strong>A-nom V X-acc</strong></td><td>&lt;&gt; </td><td><strong>X-nom V-<em>sja</em></strong></td></tr>
  <tr><td></td><td></td><td colspan="2">(e.g. <em>lomat'</em> 'break', <em>otkryt'</em> 'open', ...)</td></tr>
  <tr></tr>
  <tr><td>German:</td><td colspan="3">Passive Voice (coded)</td></tr>
  <tr><td></td><td><strong>A-nom X-acc V</strong></td><td>&lt;&gt; </td><td><strong>X-nom <em>von</em>+A V-t+<em>werden</em></strong></td></tr>
  <tr><td></td><td></td><td colspan="2">(e.g. <em>nehmen</em>, <em>bringen</em>, <em>schicken</em>, <em>lachen</em>, ...)</td></tr>
</table>

<p>
Alternations are relevant to the project to the extent they are sensitive to
verb classification (e.g., some varieties of differential object marking apply
to any transitive verb, which does not yield an interesting clustering of verb
types). More generally for our purposes, most relevant are those alternations
which are fairly productive (not restricted to a few lexical items), but ­– most
importantly – are sensitive to lexical classes. That is, we are interested in
alternations which are distinctive for the verbal lexicon (as sampled here)
rather than in those which apply across the board or apply to just few items.
</p>

<p>
One of the alternants needs to be designated as "basic" for the purposes of the
database. In a coded alternation, this will be the alternant with no coding on
the verb. In an uncoded alternation (as well as in a doubly coded alternation),
the contributor has to choose one alternant as "basic". It is understood that
a principled decision will often be difficult or impossible, so an arbitrary
decision can be taken.
</p>

<p>
Contributors will ideally enter all (major) valency alternations of their
language into the "alternations" table of the database, but if there are more
than ten such alternations, then this will be a lot of work, and they should
contact the editors.
</p>

<p>
Then for each verb, they will have to decide whether the verb occurs in the
alternation or not, or whether it applies only marginally.
</p>

<div class="well well-small database-infobox">
  <p>DATABASE FIELDS:</p>
  <dl>
    <dt>Alternation name:</dt>
    <dd>Please find a language-specific name (ideally capitalized) for your alternation. This has no theoretical significance and is only for reference.</dd>
    <dt>Description:</dt>
    <dd>Here you should describe what the alternation does. This might be done in terms of basic and derived coding frame schemas, but often additional conditions will have to be given in prose.</dd>
    <dt>Alternation type:</dt>
    <dd>Specify whether it is a coded or an uncoded alternation.</dd>
  </dl>
  <p>relationships:</p>
  <dl>
    <dt>Alternation values:</dt>
    <dd>The alternation values (occurs regularly, occurs marginally, occurs never, no data) are best entered on the Verbs layout, but may alternatively be entered on the Alternations layout.</dd>
    <dt>Alternation examples:</dt>
    <dd>At least one example needs to be entered (generally newly created) for each alternation. This can be done on the Verbs layout, or on the Alternations layout.</dd>
  </dl>
</div>

<p class="toplink">↑ <a href="#">top</a></p><hr>
<h4>8.2. Examples of uncoded alternations</h4>

<p>
In this subsection only uncoded alternations are considered; discussion of coded
alternations is postponed to the next subsection. The two subsections should be
seen as largely complementary, as alternations will be coded by dedicated
markers in some languages (apparently especially languages with a richer
morphology) and left uncoded in other languages (like English).
</p>

<p>
We begin with English, a rather atypical example of a language with
a particularly rich set of uncoded alternations. Levin (1993) mentions, in
particular, the following alternations. (The list below mentions only fairly
productive alternations and does not include verb-coded alternations like the
passive alternation; the terminology partially differs from Levin's.)
</p>

<ol class="datatable-ex">
  <li>the Ambitransitive Alternation (<em>John broke the stick ~ The stick broke</em>)</li>
  <li>the Middle Alternation (<em>John cut the bread ~ The bread cuts easily</em>)</li>
  <li>the Reflexive Omission Alternation (<em>John washed himself ~ John washed</em>)</li>
  <li>the Reciprocal Alternation (<em>John married Mary ~ John and Mary married</em>)</li>
  <li>the Dative Alternation (<em>Mary gave the book to John ~  gave John the book</em>)</li>
  <li>the Locative Alternation (<em>John loaded the truck with hay ~ the hay onto the truck</em>)</li>
  <li>the Conative Alternation (<em>John cut the bread ~ cut at the bread</em>)</li>
  <li>the Object Omission Alternation (<em>John ate the bread ~ John ate</em>).</li>
</ol>

<p class="toplink">↑ <a href="#">top</a></p><hr>
<h4>8.3. Examples of coded alternations</h4>

<p>Languages with richer morphology often use coded alternations for many argument alternations left uncoded in English. Thus in Even, a Tungusic language, the “middle alternation” is signaled by the mediopassive marker, the “inchoative-causative alternation” is signaled by the causative marker (in competition with the mediopassive), while equivalents of English verbs allowing for a “reciprocal alternation” commonly involve a lexicalized sociative marker (e.g. <em>baka-lda</em> [find-SOC] ‘meet’).</p>

<p>One can use taxonomy for the domain of verb-coded alternations, as we adopted for (uncoded) coding alternations:</p>

<ul>
  <li>Valency-reducing alternations, coming in several subtypes:
    <ol>
      <li>Subject-demoting/deleting alternations</li>
        <ul>
          <li>anticausative</li>
          <li>middle</li>
          <li>reflexive</li>
          <li>reciprocal</li>
        </ul>
      <li>Object-demoting/deleting alternations</li>
        <ul>
          <li>antipassive</li>
        </ul>
      <li>Subject-Object rearranging alternations</li>
        <ul>
          <li>passive (differs from anticausative in that A may be expressed, or is implied)</li>
        </ul>
      </ol>
  </li>
  <li>
    Valency-increasing and valency-rearranging alternations, especially
    causatives and applicatives; the latter however may rearrange rather than
    increase the valency. In some languages, the same marker is used both in
    causative and applicative functions; also for such cases it is important to
    determine which verbs select for which function.
  </li>
</ul>

<p>
Note that some languages have several causative markers, for example, for
building intransitive vs. transitive causatives. These can be used to test for
transitivity of less prototypical transitive verbs.
</p>

<p>
There may be several subtypes of applicatives, depending on which object is
promoted (for example, in Hoocąk (Siouan), there are 4 different applicative
markers, including the benefactive applicative, the instrumental applicative and
two types of locative applicatives). On the other hand, the general applicative
in Salish has been claimed to have different meanings depending on the verb’s
class. Applicatives may be used to render many of the alternations listed in
§8.2, including the dative shift, or locative alternation (cf. (f)).  Other
languages may use directional markers to code some of these alternations (cf.
Russian <em><strong>na</strong>-gruzit’ seno na telegu</em> [PREF-load hay on
cart] ‘to load the hay on the cart’ vs. <em><strong>za</strong>-gruzit’ telegu
senom</em> [PREF-load cart hay.INS] ‘to load the cart with hay’; German
<em>laden</em> vs. <em><strong>be</strong>-laden</em>).
</p>

<p>
Not all alternations can be easily classified as valency-increasing/rearranging
or valency-reducing. For example, some (Austronesian) languages show a variety
of “voice” (or “focus”)  forms (“actor focus”, “goal focus”, etc), used for
‘promotion’ of different objects to the subject position; for these languages it
will be relevant which Vs allow for which voice constructions. On the other
hand, head-marking languages of the “hierarchical type” show a direct-inverse
alternation triggered by the relative prominence of the A and P arguments. In
that case it is relevant to study the use of direct-inverse alternations with
different groups of two and three argument verbs (in the latter case, it is also
relevant which of the object arguments takes part in the alternation; e.g.,
Theme or Recipient of a ditransitive verb). But also for the domain of
monotransitives some languages may show further differentiation; e.g., some
languages (like Tlapanec) may have different inverse forms for different
subtypes of 2-argument verbs.
</p>

<p class="toplink">↑ <a href="#">top</a></p><hr>
<h3 id="optional_advanced_features">9. Optional advanced features</h3>

<h4>9.1. Ten additional verb meanings</h4>

<p>For ten additional verb meanings, counterparts may optionally be given, see Table 2.</p>

<p><strong>Table 2: Ten additional verb meanings</strong></p>

<table class="table table-bordered table-striped" style="width:auto">
  <tr><td>BRING</td><td>A brings T to R</td><td>The girl brought flowers to me.</td></tr>
  <tr><td>PUSH</td><td>A pushes P (somewhere (L))</td><td>The boy pushed the girl (into the water).</td></tr>
  <tr><td>DIG</td><td>A digs (for X)</td><td>The woman is digging for potatoes.</td></tr>
  <tr><td>WIPE</td><td>A wipes T (off X)</td><td>The women wiped dirt off the table.</td></tr>
  <tr><td>STEAL</td><td>A steals T (from X)</td><td>The thief stole money from the old lady.</td></tr>
  <tr><td>GRIND</td><td>A grinds P (with I)</td><td>The women ground the seeds (with mortar and pestle).</td></tr>
  <tr><td>HEAR</td><td>E hears M</td><td>The boy heard the bear.</td></tr>
  <tr><td>TEACH</td><td>A teaches R T</td><td>The old lady taught the girl a song.</td></tr>
  <tr><td>COOK</td><td>A cooks P</td><td>The women cooked the meat.</td></tr>
  <tr><td>BOIL</td><td>S boils</td><td>The water is boiling.</td></tr>
</table>

<p class="toplink">↑ <a href="#">top</a></p><hr>
<h4>9.2. Adding more verbs</h4>

<p>
For each <strong>alternation</strong>, and for each
<strong>coding frame</strong>, optionally additional verbs may be entered which
are not counterparts of the pre-defined meanings and which undergo the
alternation and which occur in the coding frame. These further verbs should be
linked to newly created meanings (see §9.3).
</p>

<p>
Ideally, the information provided on these additional verbs would be complete,
i.e. it would include the coding frame (also if the verb is given as an
additional example of an alternation) and the behaviour in alternations (also if
the verb is given as an additional example of a coding frame).
</p>

<p class="toplink">↑ <a href="#">top</a></p><hr>
<h4>9.3. Adding more verb meanings</h4>

<p>
In addition to the 70 pre-defined verb meanings, users may create further verb
meanings if they want to enter verbs that have other meanings.
</p>

<div class="well well-small database-infobox">
  <p>DATABASE FIELDS:</p>
  <dl>
    <dt>Meaning label:</dt>
    <dd>The meaning label is the closest English verb, in capitals.</dd>
    <dt>Role frame:</dt>
    <dd>Please give a role frame involving variables for the arguments so that coding frames can be related to the meanings of the verbs.</dd>
    <dt>Comments:</dt>
    <dd>You may give any kinds of comments.</dd>
  </dl>
</div>

<p class="toplink">↑ <a href="#">top</a></p><hr>
<h4>9.4. Characterizing coding-frame classes</h4>

<p>
If a coding frame is used for an open class of verbs (i.e. if it is productive),
please specify (optionally) which verbs may belong to this class (in terms of
relevant semantic or formal features). This should be done in the field
"Coding-frame class". (For highly restricted classes, the best way of
characterizing them would be to give additional verbs, see §9.2.)
</p>

<p class="toplink">↑ <a href="#">top</a></p><hr>
<h4>References</h4>

<p>Apresjan, Jurij D. 1967. <em>Eksperementaljnoe issledovanie russkogo glagola.</em> Moskva: Nauka.</p>

<p>Dixon R. M. W. 1991/2002. <em>A New Approach to English Grammar, on Semantic
Principles.</em> Oxford: Clarendon Press.</p>

<p>Haspelmath, Martin. 2005. Ditransitive Constructions: The Verb ‘Give’. In:
Haspelmath &amp; al. (eds.), 426–429.</p>

<p>Levin, Beth. 1993. <em>English Verb Classes and Alternations.</em> Chicago:
University of Chicago Press</p>

<p>Malchukov, Andrej, Martin Haspelmath, and Bernard Comrie. 2010. Ditransitive
constructions: a typological overview. To appear in Malchukov, A., M.
Haspelmath, and B. Comrie (eds.). <em>Studies in Ditransitive constructions.
A comparative handbook.</em> Berlin: De Gruyter Mouton.</p>

<p>Sauerland, Uli. 1994. German diathesis and verb morphology. In: Jones, Doug
(ed). 1994. <em>Working Papers and Projects on Verb Class Alternations in
Bangla, German, English, and Korean.</em> MIT AI Memo 1517, 37–92.</p>

<p class="toplink">↑ <a href="#">top</a></p><hr>
<h4>Footnotes</h4>

## TODO tooltips for the footnotes?
<ol>
<li id="ftn1">
Note that the ordering of the verbs in Table 1 (from potentially/frequently
zero-valent, through monovalent and divalent to trivalent) is somewhat different
from the ordering in the database. The ordering is of course irrelevant.
</li>

<li id="ftn2">
Please note that the list of verbs was somewhat updated with respect to the June
2010 version of the questionnaire and of the database (at the time there were
some discrepancies between them).
</li>

<li id="ftn3">
In some cases, it is impossible to give basic counterparts, as in the case where
all ditransitives including 'give' are derived (applicative, as in the Mayan
language Tzotzil).  Therefore it is important to provide information about
morphological complexity of Vs. This question is relevant also insofar as the
morphological make-up may determine the availability of a certain valency
pattern. For example, in Malayalam, only derived ditransitives (causatives of
transitives), take a double object construction, while basic (underived)
ditransitives take a dative construction.
</li>

<li id="ftn4">
This question is relevant insofar as the valency pattern may be motivated
through one of the meanings of the polyfunctional item. For example, in some
languages, which use the same verbs for both ‘hit’ and ‘throw’, this verb
follows the allative pattern, as expected for caused motion verbs. Similarly,
a verb may have a valency pattern that is motivated by its etymological meaning,
not by any of the current meanings.
</li>

<li id="ftn5">
If the alternation patterns are different for different subclasses of verbs, the
contributor is requested to provide several examples illustrating the
differences (e.g., if the causative derivation produces different structures
when applied to intransitives and transitives, as is frequently the case; here
at least two examples of the causative construction should be given).
</li>

<li id="ftn6">
We often use letters that can be thought of as standing mnemonically for
particular roles (A: agent, P: patient, S: single central argument of
intransitive verb, T: theme (of ditransitive verb), R: recipient (of
ditransitive verb), L: location (including goal), I: instrument, E: experiencer,
M: stimulus, X, Y, Z: other). No claims are associated with the use of these
letters, and they could be replaced by other arbitrary variable symbols.
</li>

<li id="ftn7">
Some languages make word-order distinctions depending on the valency class.
Thus, in (Gao) Songhay, canonical transitives (‘break’, ‘kill’) have SOV order,
while less canonical bivalent verbs (‘see’, ‘follow’, ‘love’) have SVO order.
</li>

<li id="ftn8">
Two coding frames may differ only in the optionality vs. obligatoriness of
a coding element. For example, in the Austronesian language Manam some
experiencer verbs (‘like’, ‘know’, ‘be bad at’) use primary-object indexing only
when the primary object is prominent, while canonical transitives (like
‘break’), invariably index the primary object. And in Newari, the availability
of an ergative pattern depends on tense, on the one hand, and on lexical class
of the verb, on the other hand, so that two-argument verbs deviating from the
transitive prototype can take the ergative pattern optionally.
</li>

<li id="ftn9">
We considered two ways of avoiding an arbitrary choice: (i) by allowing the
association of a verb with two or more coding frames (but in this way, we would
have lost the information that the use of two coding frames is systematic rather
than verb-specific), and (ii) by capturing alternations in a very different way,
not via a separate alternations table, but via different coding frames that may
be associated with a single verb stem (but in this way, we would have lost the
ability of comparing alternations across languages). Clearly, no choice of
representation mode is ideal.
</li>
</ol>

</div>
