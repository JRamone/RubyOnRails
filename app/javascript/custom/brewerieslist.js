const BREWERIES = {};

const createTableRow = (brewery) => {
    const tr = document.createElement("tr");
    tr.id = brewery.id;
    const breweryname = tr.appendChild(document.createElement("td")); 
    breweryname.innerHTML = brewery.name;
    const breweryfounded = tr.appendChild(document.createElement("td")); 
    breweryfounded.innerHTML = brewery.year;
    const breweryactive = tr.appendChild(document.createElement("td")); 
    breweryactive.innerHTML = brewery.active? "Yes" : "No";
    const brewerybeercount = tr.appendChild(document.createElement("td")); 
    brewerybeercount.innerHTML = brewery.beercount

    return tr;
};

const handleResponse = (data) => {
    BREWERIES.list = JSON.parse(data.target.response);
    BREWERIES.show();
};


BREWERIES.show = () => {
    const table = document.getElementById("brewerylist");

    // Clear TABLEBODY of any children
    document.getElementById("brewerylist").innerHTML = ""; 

    BREWERIES.list.forEach((b) => {
        const tr = createTableRow(b);
        table.appendChild(tr);
    });
};

// Order functions
BREWERIES.orderByName = () => {
    BREWERIES.list.sort((a,b) => {
        return a.name.toUpperCase().localeCompare(b.name.toUpperCase());
    });
};

BREWERIES.orderByYear = () => {
    BREWERIES.list.sort((a,b) => { return a.year - b.year } );
};

BREWERIES.orderByBeercount = () => {
    BREWERIES.list.sort((a,b) => { return b.beercount - a.beercount } );
};



const breweries = () => {
    if (document.querySelectorAll("#brewerytable").length < 1) return;

    //Event listeners
    document.getElementById("name").addEventListener("click", (e) => {
        e.preventDefault();
        BREWERIES.orderByName();
        BREWERIES.show();
    });

    document.getElementById("founded").addEventListener("click", (e) => {
        e.preventDefault();
        BREWERIES.orderByYear();
        BREWERIES.show();
    });
    
    document.getElementById("beercount").addEventListener("click", (e) => {
        e.preventDefault();
        BREWERIES.orderByBeercount();
        BREWERIES.show();
    });

    const request = new XMLHttpRequest();
    request.onload = handleResponse;
    request.open("GET", "breweries.json", true);
    request.send();
};

export { breweries };
