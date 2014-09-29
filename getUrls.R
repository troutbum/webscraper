# load packages
library(RCurl)
library(XML)

get_google_page_urls <- function(u) {
        # read in page contents
        html <- getURL(u)
        
        # parse HTML into tree structure
        doc <- htmlParse(html)
        
        # extract url nodes using XPath. Originally I had used "//a[@href][@class='l']" until the google code change.
        attrs <- xpathApply(doc, "//h3//a[@href]", xmlAttrs)
        
        # extract urls
        links <- sapply(attrs, function(x) x[[1]])
        
        # free doc from memory
        free(doc)
        
        # ensure urls start with "http" to avoid google references to the search page
        links <- grep("http://", links, fixed = TRUE, value=TRUE)
        return(links)
}

# u <- "http://www.google.co.uk/search?aq=f&gcx=w&sourceid=chrome&ie=UTF-8&q=r+project"
u <- "https://class.coursera.org/neuraldata-001/lecture"

get_google_page_urls(u)

# [1] "http://www.r-project.org/"
# [2] "http://en.wikipedia.org/wiki/R_(programming_language)"
# [3] "http://www.rseek.org/"
# [4] "http://www.gutenberg.org/browse/authors/r"
# [5] "http://sciviews.org/_rgui/"
# [6] "http://www.itc.nl/~rossiter/teach/R/RIntro_ITC.pdf"
# [7] "http://stat.ethz.ch/CRAN/"
# [8] "http://hughesbennett.co.uk/RProject"
# [9] "http://www.warwick.ac.uk/statsdept/user-2011/"