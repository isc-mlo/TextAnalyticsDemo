/// Embedded Python methods to use Azure Text Analytics
/// Prerequisite:
/// pip install --target <installdir>\mgr\python azure-ai-textanalytics --pre --upgrade
Class EmbeddedPython.Analyzer Extends %RegisteredObject
{

/// Authenticate to Azure and return a client object
ClassMethod Authenticate() [ Language = python ]
{

    key = "api-key-goes-here"
    endpoint = "https://mark-text-analytics.cognitiveservices.azure.com/"

    from azure.ai.textanalytics import TextAnalyticsClient
    from azure.core.credentials import AzureKeyCredential

    def authenticate_client():
        ta_credential = AzureKeyCredential(key)
        text_analytics_client = TextAnalyticsClient(endpoint=endpoint, credential=ta_credential)
        return text_analytics_client

    client = authenticate_client()

    return client
}

/// Analyze the sentiment in a collection of documents
/// As of 5/14/21, this is printing the request and response headers. 
/// I have no idea why. Maybe they will go away again
ClassMethod Sentiment(client, name, text) [ Language = python ]
{

    def sentiment_analysis_example(client):
        # documents is a collection, but we are only doing one response at a time.
        documents = [ text ]
        response = client.analyze_sentiment(documents=documents)[0]
        print("\nParticipant: " + name)
        print("Sentiment: {}".format(response.sentiment))
        print("Overall scores: positive={0:.2f}; neutral={1:.2f}; negative={2:.2f} \n".format(
            response.confidence_scores.positive,
            response.confidence_scores.neutral,
            response.confidence_scores.negative,
        ))
        for idx, sentence in enumerate(response.sentences):
            print("Sentence: {}".format(sentence.text))
            print("Sentence {} sentiment: {}".format(idx+1, sentence.sentiment))
            print("Sentence score:\nPositive={0:.2f}\nNeutral={1:.2f}\nNegative={2:.2f}\n".format(
                sentence.confidence_scores.positive,
                sentence.confidence_scores.neutral,
                sentence.confidence_scores.negative,
        ))
          
    sentiment_analysis_example(client)
}

}
