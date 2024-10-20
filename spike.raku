class Site {
    has Page    @.pages;
    has Header  $.header;
    has Footer  $.footer;
}

class Header {
    has Logo    $.logo;
    has Title   $.title;
    has Nav     $.nav;
}

class Company {
    has Name[Company]   $.name;
    has Address         $.address;
    has Phone           $.phone;
    has Email           $.email;
}

class Footer {
    has Social          @.socials;
    has Company         $.company;
    has Nav[List]       $.info-nav;
}