# WiGLE API
This gem was written to make use of WiGLE.net's wireless access point data. Currently WiGLE doen't provide and official API so this gem may break if they change their interface. This was written to make use of the data for a single small scale project for a public display and is no longer actively used and I have no intention of maintaining it (though it's fairly simple).

## Usage
To make use of this you'll need to create an account on wigle.net (<http://wigle.net/gps/gps/main/register>). The following code example shows how to authenticate against the API and perform a simple search.

   require "wigle\_api"

   WigleApi.login("your-username", "your-password")
   WigleApi.where(ssid: "linksys").each do |ap|
     puts ap[:ssid] + ap[:statecode]
   end

   WigleApi.where(ssid: "linksys").offset(200).results

Results are returned as an array of hashes with symbols for keys. Each hash has all of the available fields that WiGLE returns in their search view. Only 100 results will be returned at a time though you can use the "pagestart" search value or the .offset(num) chained methods to iterate through more results. There unfortunately isn't a way to count the total number of results from a query at this time.

## Available Search Parameters

* addresscode - Street address, max length 30
* statecode - Two character state code
* zipcode - Five character integer zip code, maxlength 5
* variance - The latitude/longitude variance in degrees, values available in the form: 0.001, 0.002, 0.005, 0.010 (default), 0.020, 0.050, 0.100, 0.200
* latrange1 - Begin latitude range, max length 14
* latrange2 - End latitude range, max length 14
* longrange1 - Begin longitude range, max length 14
* longrange2 - End longitude range, max length 14
* lastupdt - A timestamp used to filter based on the last time the access point database was updated in the format of 20010925174546
* netid - BSSID / AP Max Address, expects either just the colon delimited vendor code or a full MAC such as either 0A:2C:EF or 0A:2C:EF:3D:25:1B, max length 14
* ssid - SSID / Network Name, max length 50
* freenet - Must be a freenet (Not sure what that means), set the value to on to filter with this, should be excluded completely otherwise
* paynet - Must be a Commercial Pay Net (Not sure what that means either...), same deal with on to filter with this
* dhcp - Must have DHCP enabled, on again to filter with this...
* onlymine - Only search on the networks that the authenticated user has found
* pagestart - The search result offset

## Personal Notes on WiGLE
While writing this Gem I got the distinct feeling that the operators of WiGLE.net aren't particularily friendly people. How they've managed to convince so many people to provide them with all this data is beyond me as they don't seem willing to return the favor of actually making the data available to their users.

From the many forum posts requesting an API it seem's like the owners of WiGLE don't want an official way to access the data in their database for one of the reasons below:

* They want to keep the data for themselves (possibly for commercial reasons)
* They don't want to spend the time/energy coding an actual API
* They are worried about bandwidth (and are not open to the idea of mirrors)
* They are simply (insert insult here)

Usually requests for making use of the data on the site are turned down rudely, and usually with various references to cats.

