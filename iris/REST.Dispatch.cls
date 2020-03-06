Class REST.Dispatch Extends %CSP.REST
{

XData UrlMap [ XMLNamespace = "http://www.widgetsdirect.com/urlmap" ]
{
<Routes>
    <Route Url="/:name" Method="GET" Call="HelloWorld" Cors="false" />
</Routes>
}

ClassMethod HelloWorld(Name As %String) As %Status
{
    set %response.ContentType = "application/json"

    set retObj = {}

    set retMessage = "Welcome to Widgets Direct "_Name
    set retObj.Message = retMessage

    #; set widgetArray = []
    #; for i=1:1:10 {
    #;     set widgetObj = {}
    #;     set widgetObj.Id = i
    #;     set widgetObj.Name = "Widget "_i
    #;     do widgetArray.%Push(widgetObj)
    #; }
    #; set retObj.Widgets = widgetArray

    // Perform Dynamic SQL 
    set myquery = "select * from SQLUser.Widget"

    set tStatement = ##class(%SQL.Statement).%New()
    set tStatement.%SelectMode = 1  // set the mode to ODBC
    set qStatus = tStatement.%Prepare(myquery)
    if qStatus'=1 { write "%Prepare failed",$System.Status.DisplayError(qStatus) QUIT}

    set rset = tStatement.%Execute()
    
    // Iterate through the result set
    set widgetArray = []
    while rset.%Next(){		
        #; set ^jintest =  rset
        #; set widgetObj = {}
        #; set widgetObj.Id = rset.Id
        #; set widgetObj.Name = rset.Name
        #; set widgetObj.Description = rset.Description
        #; set widgetObj.Price = rset.Price
        #; set widgetObj.Quantity = rset.Quantity

        set widgetObj = ##class(User.Widget).%OpenId(rset.Id)

        #; do widgetArray.%Push(widgetObj)
        do widgetArray.%Push(widgetObj.toJSON())
    }
    set retObj.Widgets = widgetArray

    write retObj.%ToJSON()

    quit $$$OK
}

}
