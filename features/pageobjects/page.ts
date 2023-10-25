import { browser } from '@wdio/globals';
import { $ } from '@wdio/globals'

/**
* main page object containing all methods, selectors and functionality
* that is shared across all page objects
*/
export default class Page {
    /**
    * Opens a sub page of the page
    * @param path path of the sub page (e.g. /path/to/page.html)
    */
    public async open(path: string) {

        await browser.url(`https://www.amazon.in/`)//https://the-internet.herokuapp.com/${path},https://webdriver.io
       

        //     await browser.saveScreen('examplePaged', {
        //      /* some options */
        //  })

        //  // Save an element
        //  await browser.saveElement(
        //      await $('#element-id'),
        //      'firstButtonElement',
        //      {
        //          /* some options */
        //      }
        //  )}

        //-------------------------------------------------------------------

        console.log("Start - Img function");

        try {
           // await browser.url("https://www.amazon.in/");

            await browser.checkScreen('amazon-homepage', {})
           // await browser.saveFullPageScreen('amazon-homepage', {});

            await $("#twotabsearchtextbox").setValue("Shirts");
            await browser.pause(2000);

            const result = await browser.checkElement(await $("#nav-flyout-searchAjax"), 'searchbar-suggestions', {});
           // expect(result).toEqual(0);
        } catch (error: any) {
            console.log("Error:", error.message);
        }

        console.log("End-Img function");

    }
}
