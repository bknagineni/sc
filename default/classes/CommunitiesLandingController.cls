/**
 * An apex page controller that takes the user to the right start page based on credentials or lack thereof
 */
public with sharing class CommunitiesLandingController {
    
    // Code we will invoke on page load.
    public PageReference forwardToStartPage() {
        return Network.communitiesLanding();
    }
    
    public CommunitiesLandingController() {}
    public PageReference forwardToCustomAuthPage() 
    {
        String startUrl = System.currentPageReference().getParameters().get('startURL');
        return new PageReference(Site.getPrefix() + '/SiteLogin?startURL=' +
        EncodingUtil.urlEncode(startURL, 'UTF-8'));
    }
}