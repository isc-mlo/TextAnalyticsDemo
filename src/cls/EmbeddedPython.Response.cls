/// Responses to analyze for overall sentiment using Azure Text Analytics
/// call Run() to run.
Class EmbeddedPython.Response Extends %Persistent
{

Property Name As %String;

Property Response As %String(MAXLEN = 1024);

/// Asks a bunch of people about their day
ClassMethod Ask()
{

    write !, "This method will capture responses from a number of people."
    write !, "Type a return at the any prompt when there are no more people to ask."

    for {
        read !!, "What is your name? " , name
        quit:(name = "")  // user entered nothing
        write !!, "Hello, ", name, ". "
        read "Tell me about your day: ", !!, response
        quit:(response = "")

        set r = ..%New()
        set r.Name = name
        set r.Response = response
        do r.%Save()
    }
}

/// Query for all stored names
Query Select() As %SQLQuery [ SqlProc ]
{
  SELECT %ID, Name, Response 
  FROM EmbeddedPython.Response
  ORDER By Name
}

/// Analyze the responses
ClassMethod Analyze(client As %String)
{

    write !, "This method will look at all the stored responses and analyze the sentiment in the responses.", !!

    set stmt = ##class(%SQL.Statement).%New()
    set status = stmt.%PrepareClassQuery("EmbeddedPython.Response", "Select")
    
    if $$$ISERR(status) { 
        do $system.OBJ.DisplayError(status)
        quit  
    }
    
    set resultSet = stmt.%Execute() 

    while resultSet.%Next() {
        set id = resultSet.%Get("ID")
        set name = resultSet.%Get("Name")
        set text = resultSet.%Get("Response")
        // write name, " (", id, ")", !
        // write text, !!
        do ##class(EmbeddedPython.Analyzer).Sentiment(client, name, text)
    }
}

/// Main driver method
ClassMethod Run()
{
    write !, "GATHERING NEW RESPONSES"
    do ..Ask()
    write !!, "AUTHENTICATING TO AZURE",!
    set client = ##class(EmbeddedPython.Analyzer).Authenticate()
    write !, "ANALYZING ALL STORED RESPONSES"
    do ..Analyze(client)
}

Storage Default
{
<Data name="ResponseDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
<Value name="3">
<Value>Response</Value>
</Value>
</Data>
<DataLocation>^EmbeddedPython.ResponseD</DataLocation>
<DefaultData>ResponseDefaultData</DefaultData>
<IdLocation>^EmbeddedPython.ResponseD</IdLocation>
<IndexLocation>^EmbeddedPython.ResponseI</IndexLocation>
<StreamLocation>^EmbeddedPython.ResponseS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
