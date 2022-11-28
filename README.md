<h3 id="myHeading">Playing with .csv files </h3>

**I was given an assignment, I had to use pandas to extract some info from a imdb.csv file.**

*You can see the assignment below :*

<img src="assignment.png" width="600em" height="350em">

---

But, as I am learning about unix/linux.
:bulb: An idea struck me! :bulb:
I thought why not do it on bash.

And, here we are ...

<h4 id="">The steps I followed were: </h4>

1. Since, files separated by comma(,) are hard to use with commands like awk or sed.
   I decided to convert to a tsv or tab-separated file. <br>
   As for why csv files don't work very well with awk or sed.[See Here](#myHeading)

2. Now, to convert a csv to tsv, you can use your spreadsheet software or cli tool. In my case,
   I used a simple python script with csv module. [Link Here](https://github.com/RohitSingh496/playingwith-csvfiles/blob/master/csv2tab) <br>
   To use the script just cat out the csv and pipe it to the script and save it to a new file: <br>
   `cat imdb.csv | ./csv2tab > imdb.tsv`

3. - Separate Movies samples with ratings more than 8.5 .<br>
    `awk -F'\t' '$1>8.5 {print}' imdb.tsv > separated.tsv`
 
   - Number of Movies in each genre?<br>
     Get a list of all the genre and save to genrelist txt file:  <br>
     `awk -F'\t' '{print $4}' imdb.tsv | sort | uniq > genrelist`
 
     Now, count movies in each genre: <br>
     `grep -ic 'Genre' imdb.tsv`
 
     Or, to do it all in one go:<br>
     `while IFS= read -r line; do value=$(grep -ic $line imdb.tsv) ; echo "$line | $value" ; done < genrelist`
 
4.

