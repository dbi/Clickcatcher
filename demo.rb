# prereq.
# $ gem install sinatra
#
# start with
# $ ruby demo.rb
#
# source highlighter from http://quickhighlighter.com

require 'rubygems'
require 'sinatra'

get '/' do
  erb :index
end

get '/slow-request.js' do
  sleep 5
  content_type 'text/javascript'
  erb :script
end

__END__

@@index
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
  <head>
    <title>Clickcatcher proof of concept</title>
    <style type="text/css" media="screen">
      #main {
        max-width: 780px;
        margin-left: 20px;
      }
      ul {
        margin-top:0.5em;
      }
    </style>
    <script src="http://code.jquery.com/jquery-1.4.2.min.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" charset="utf-8">
QUEUE = {
  clicks : [],
  click_handler : function (evt) {
    if ($(evt.target).hasClass("guarded")) {
      QUEUE.clicks.push({
        evt : evt,
        target : evt.target
      });
      return false;
    }
    return true;
  }
};

(function () {
  $(document).bind("click", QUEUE.click_handler);
  $(document).ready(function () {
    // setTimeout make sure this function is executed after everthing
    // else when load is triggered.
    setTimeout(function () {
       $(document).unbind("click", QUEUE.click_handler);
       for (var i=0, il=QUEUE.clicks.length; i<il; i++) {
         $(QUEUE.clicks[i].target).click();
       }
    }, 0);
  });
})();
    </script>
  </head>
  <body>
    <div id="main">
      <h1>Clickcatcher proof of concept</h1>
      
      <h2>Problem</h2>
      <p>If you add behaviour to links with javascript and the page is slow to load.
        Clicking on a link will break the page.</p>
        
      <h2>Example</h2>
      <p>Say we have a link.</p>
      <div class="javascript" style="font-size:0.8em;font-family:monospace;color: #006; border: 1px solid #d0d0d0; background-color: #f0f0f0;"><ol><li style="font-weight: normal; vertical-align:top;font: normal normal 130% 'Courier New', Courier, monospace; color: #003030;"><div style="font: normal normal 1em/1.2em monospace; margin:0; padding:0; background:none; vertical-align:top;color: #000020;"><span style="color: #339933;">&lt;</span>a <span style="color: #003366; font-weight: bold;">class</span><span style="color: #339933;">=</span><span style="color: #3366CC;">&quot;guarded&quot;</span> href<span style="color: #339933;">=</span><span style="color: #3366CC;">&quot;http://www.example.org&quot;</span><span style="color: #339933;">&gt;</span>Magic link<span style="color: #339933;">&lt;/</span>a<span style="color: #339933;">&gt;</span></div></li>
      </ol></div>
      <p>We want to display an alert box when this link is clicked. So we add this script to the bottom of the page.</p>
      <div class="javascript" style="font-size:0.8em;font-family:monospace;color: #006; border: 1px solid #d0d0d0; background-color: #f0f0f0;"><ol><li style="font-weight: normal; vertical-align:top;font: normal normal 130% 'Courier New', Courier, monospace; color: #003030;"><div style="font: normal normal 1em/1.2em monospace; margin:0; padding:0; background:none; vertical-align:top;color: #000020;"><span style="color: #006600; font-style: italic;">// slow-request.js (will take 5 seconds to load)</span></div></li>
      <li style="font-weight: normal; vertical-align:top;font: normal normal 130% 'Courier New', Courier, monospace; color: #003030;"><div style="font: normal normal 1em/1.2em monospace; margin:0; padding:0; background:none; vertical-align:top;color: #000020;">$<span style="color: #009900;">&#40;</span>document<span style="color: #009900;">&#41;</span>.<span style="color: #660066;">ready</span><span style="color: #009900;">&#40;</span><span style="color: #003366; font-weight: bold;">function</span> <span style="color: #009900;">&#40;</span><span style="color: #009900;">&#41;</span> <span style="color: #009900;">&#123;</span></div></li>
      <li style="font-weight: normal; vertical-align:top;font: normal normal 130% 'Courier New', Courier, monospace; color: #003030;"><div style="font: normal normal 1em/1.2em monospace; margin:0; padding:0; background:none; vertical-align:top;color: #000020;">&nbsp; $<span style="color: #009900;">&#40;</span><span style="color: #3366CC;">'.guarded'</span><span style="color: #009900;">&#41;</span>.<span style="color: #660066;">click</span><span style="color: #009900;">&#40;</span><span style="color: #003366; font-weight: bold;">function</span><span style="color: #009900;">&#40;</span><span style="color: #009900;">&#41;</span> <span style="color: #009900;">&#123;</span></div></li>
      <li style="font-weight: normal; vertical-align:top;font: normal normal 130% 'Courier New', Courier, monospace; color: #003030;"><div style="font: normal normal 1em/1.2em monospace; margin:0; padding:0; background:none; vertical-align:top;color: #000020;">&nbsp; &nbsp; <span style="color: #000066;">alert</span><span style="color: #009900;">&#40;</span><span style="color: #3366CC;">&quot;success!&quot;</span><span style="color: #009900;">&#41;</span><span style="color: #339933;">;</span></div></li>
      <li style="font-weight: normal; vertical-align:top;font: normal normal 130% 'Courier New', Courier, monospace; color: #003030;"><div style="font: normal normal 1em/1.2em monospace; margin:0; padding:0; background:none; vertical-align:top;color: #000020;">&nbsp; &nbsp; <span style="color: #000066; font-weight: bold;">return</span> <span style="color: #003366; font-weight: bold;">false</span><span style="color: #339933;">;</span></div></li>
      <li style="font-weight: normal; vertical-align:top;font: normal normal 130% 'Courier New', Courier, monospace; color: #003030;"><div style="font: normal normal 1em/1.2em monospace; margin:0; padding:0; background:none; vertical-align:top;color: #000020;">&nbsp; <span style="color: #009900;">&#125;</span><span style="color: #009900;">&#41;</span><span style="color: #339933;">;</span></div></li>
      <li style="font-weight: normal; vertical-align:top;font: normal normal 130% 'Courier New', Courier, monospace; color: #003030;"><div style="font: normal normal 1em/1.2em monospace; margin:0; padding:0; background:none; vertical-align:top;color: #000020;"><span style="color: #009900;">&#125;</span><span style="color: #009900;">&#41;</span><span style="color: #339933;">;</span></div></li>
      </ol></div>
      <p>If we have a slow loading page, this means we have a problem.</p>
      <img src="clickcatcher.png" alt="visualized">
      
      <h2>Solution</h2>
      <p>Put dangerous click events on hold until the document is fully loaded.</p>
      <div class="javascript" style="font-size:0.8em;font-family:monospace;color: #006; border: 1px solid #d0d0d0; background-color: #f0f0f0;"><ol><li style="font-weight: normal; vertical-align:top;font: normal normal 130% 'Courier New', Courier, monospace; color: #003030;"><div style="font: normal normal 1em/1.2em monospace; margin:0; padding:0; background:none; vertical-align:top;color: #000020;">QUEUE <span style="color: #339933;">=</span> <span style="color: #009900;">&#123;</span></div></li>
      <li style="font-weight: normal; vertical-align:top;font: normal normal 130% 'Courier New', Courier, monospace; color: #003030;"><div style="font: normal normal 1em/1.2em monospace; margin:0; padding:0; background:none; vertical-align:top;color: #000020;">&nbsp; clicks <span style="color: #339933;">:</span> <span style="color: #009900;">&#91;</span><span style="color: #009900;">&#93;</span><span style="color: #339933;">,</span></div></li>
      <li style="font-weight: normal; vertical-align:top;font: normal normal 130% 'Courier New', Courier, monospace; color: #003030;"><div style="font: normal normal 1em/1.2em monospace; margin:0; padding:0; background:none; vertical-align:top;color: #000020;">&nbsp; click_handler <span style="color: #339933;">:</span> <span style="color: #003366; font-weight: bold;">function</span> <span style="color: #009900;">&#40;</span>evt<span style="color: #009900;">&#41;</span> <span style="color: #009900;">&#123;</span></div></li>
      <li style="font-weight: normal; vertical-align:top;font: normal normal 130% 'Courier New', Courier, monospace; color: #003030;"><div style="font: normal normal 1em/1.2em monospace; margin:0; padding:0; background:none; vertical-align:top;color: #000020;">&nbsp; &nbsp; <span style="color: #000066; font-weight: bold;">if</span> <span style="color: #009900;">&#40;</span>$<span style="color: #009900;">&#40;</span>evt.<span style="color: #660066;">target</span><span style="color: #009900;">&#41;</span>.<span style="color: #660066;">hasClass</span><span style="color: #009900;">&#40;</span><span style="color: #3366CC;">&quot;guarded&quot;</span><span style="color: #009900;">&#41;</span><span style="color: #009900;">&#41;</span> <span style="color: #009900;">&#123;</span></div></li>
      <li style="font-weight: normal; vertical-align:top;font: normal normal 130% 'Courier New', Courier, monospace; color: #003030;"><div style="font: normal normal 1em/1.2em monospace; margin:0; padding:0; background:none; vertical-align:top;color: #000020;">&nbsp; &nbsp; &nbsp; QUEUE.<span style="color: #660066;">clicks</span>.<span style="color: #660066;">push</span><span style="color: #009900;">&#40;</span><span style="color: #009900;">&#123;</span></div></li>
      <li style="font-weight: normal; vertical-align:top;font: normal normal 130% 'Courier New', Courier, monospace; color: #003030;"><div style="font: normal normal 1em/1.2em monospace; margin:0; padding:0; background:none; vertical-align:top;color: #000020;">&nbsp; &nbsp; &nbsp; &nbsp; evt <span style="color: #339933;">:</span> evt<span style="color: #339933;">,</span></div></li>
      <li style="font-weight: normal; vertical-align:top;font: normal normal 130% 'Courier New', Courier, monospace; color: #003030;"><div style="font: normal normal 1em/1.2em monospace; margin:0; padding:0; background:none; vertical-align:top;color: #000020;">&nbsp; &nbsp; &nbsp; &nbsp; target <span style="color: #339933;">:</span> evt.<span style="color: #660066;">target</span></div></li>
      <li style="font-weight: normal; vertical-align:top;font: normal normal 130% 'Courier New', Courier, monospace; color: #003030;"><div style="font: normal normal 1em/1.2em monospace; margin:0; padding:0; background:none; vertical-align:top;color: #000020;">&nbsp; &nbsp; &nbsp; <span style="color: #009900;">&#125;</span><span style="color: #009900;">&#41;</span><span style="color: #339933;">;</span></div></li>
      <li style="font-weight: normal; vertical-align:top;font: normal normal 130% 'Courier New', Courier, monospace; color: #003030;"><div style="font: normal normal 1em/1.2em monospace; margin:0; padding:0; background:none; vertical-align:top;color: #000020;">&nbsp; &nbsp; &nbsp; <span style="color: #000066; font-weight: bold;">return</span> <span style="color: #003366; font-weight: bold;">false</span><span style="color: #339933;">;</span></div></li>
      <li style="font-weight: normal; vertical-align:top;font: normal normal 130% 'Courier New', Courier, monospace; color: #003030;"><div style="font: normal normal 1em/1.2em monospace; margin:0; padding:0; background:none; vertical-align:top;color: #000020;">&nbsp; &nbsp; <span style="color: #009900;">&#125;</span></div></li>
      <li style="font-weight: normal; vertical-align:top;font: normal normal 130% 'Courier New', Courier, monospace; color: #003030;"><div style="font: normal normal 1em/1.2em monospace; margin:0; padding:0; background:none; vertical-align:top;color: #000020;">&nbsp; &nbsp; <span style="color: #000066; font-weight: bold;">return</span> <span style="color: #003366; font-weight: bold;">true</span><span style="color: #339933;">;</span></div></li>
      <li style="font-weight: normal; vertical-align:top;font: normal normal 130% 'Courier New', Courier, monospace; color: #003030;"><div style="font: normal normal 1em/1.2em monospace; margin:0; padding:0; background:none; vertical-align:top;color: #000020;">&nbsp; <span style="color: #009900;">&#125;</span></div></li>
      <li style="font-weight: normal; vertical-align:top;font: normal normal 130% 'Courier New', Courier, monospace; color: #003030;"><div style="font: normal normal 1em/1.2em monospace; margin:0; padding:0; background:none; vertical-align:top;color: #000020;"><span style="color: #009900;">&#125;</span><span style="color: #339933;">;</span></div></li>
      <li style="font-weight: normal; vertical-align:top;font: normal normal 130% 'Courier New', Courier, monospace; color: #003030;"><div style="font: normal normal 1em/1.2em monospace; margin:0; padding:0; background:none; vertical-align:top;color: #000020;">&nbsp;</div></li>
      <li style="font-weight: normal; vertical-align:top;font: normal normal 130% 'Courier New', Courier, monospace; color: #003030;"><div style="font: normal normal 1em/1.2em monospace; margin:0; padding:0; background:none; vertical-align:top;color: #000020;"><span style="color: #009900;">&#40;</span><span style="color: #003366; font-weight: bold;">function</span> <span style="color: #009900;">&#40;</span><span style="color: #009900;">&#41;</span> <span style="color: #009900;">&#123;</span></div></li>
      <li style="font-weight: normal; vertical-align:top;font: normal normal 130% 'Courier New', Courier, monospace; color: #003030;"><div style="font: normal normal 1em/1.2em monospace; margin:0; padding:0; background:none; vertical-align:top;color: #000020;">&nbsp; $<span style="color: #009900;">&#40;</span>document<span style="color: #009900;">&#41;</span>.<span style="color: #660066;">bind</span><span style="color: #009900;">&#40;</span><span style="color: #3366CC;">&quot;click&quot;</span><span style="color: #339933;">,</span> QUEUE.<span style="color: #660066;">click_handler</span><span style="color: #009900;">&#41;</span><span style="color: #339933;">;</span></div></li>
      <li style="font-weight: normal; vertical-align:top;font: normal normal 130% 'Courier New', Courier, monospace; color: #003030;"><div style="font: normal normal 1em/1.2em monospace; margin:0; padding:0; background:none; vertical-align:top;color: #000020;">&nbsp; $<span style="color: #009900;">&#40;</span>document<span style="color: #009900;">&#41;</span>.<span style="color: #660066;">ready</span><span style="color: #009900;">&#40;</span><span style="color: #003366; font-weight: bold;">function</span> <span style="color: #009900;">&#40;</span><span style="color: #009900;">&#41;</span> <span style="color: #009900;">&#123;</span></div></li>
      <li style="font-weight: normal; vertical-align:top;font: normal normal 130% 'Courier New', Courier, monospace; color: #003030;"><div style="font: normal normal 1em/1.2em monospace; margin:0; padding:0; background:none; vertical-align:top;color: #000020;">&nbsp; &nbsp; <span style="color: #006600; font-style: italic;">// setTimeout make sure this function is executed after everything</span></div></li>
      <li style="font-weight: normal; vertical-align:top;font: normal normal 130% 'Courier New', Courier, monospace; color: #003030;"><div style="font: normal normal 1em/1.2em monospace; margin:0; padding:0; background:none; vertical-align:top;color: #000020;">&nbsp; &nbsp; <span style="color: #006600; font-style: italic;">// else when load is triggered.</span></div></li>
      <li style="font-weight: normal; vertical-align:top;font: normal normal 130% 'Courier New', Courier, monospace; color: #003030;"><div style="font: normal normal 1em/1.2em monospace; margin:0; padding:0; background:none; vertical-align:top;color: #000020;">&nbsp; &nbsp; setTimeout<span style="color: #009900;">&#40;</span><span style="color: #003366; font-weight: bold;">function</span> <span style="color: #009900;">&#40;</span><span style="color: #009900;">&#41;</span> <span style="color: #009900;">&#123;</span></div></li>
      <li style="font-weight: normal; vertical-align:top;font: normal normal 130% 'Courier New', Courier, monospace; color: #003030;"><div style="font: normal normal 1em/1.2em monospace; margin:0; padding:0; background:none; vertical-align:top;color: #000020;">&nbsp; &nbsp; &nbsp; &nbsp;$<span style="color: #009900;">&#40;</span>document<span style="color: #009900;">&#41;</span>.<span style="color: #660066;">unbind</span><span style="color: #009900;">&#40;</span><span style="color: #3366CC;">&quot;click&quot;</span><span style="color: #339933;">,</span> QUEUE.<span style="color: #660066;">click_handler</span><span style="color: #009900;">&#41;</span><span style="color: #339933;">;</span></div></li>
      <li style="font-weight: normal; vertical-align:top;font: normal normal 130% 'Courier New', Courier, monospace; color: #003030;"><div style="font: normal normal 1em/1.2em monospace; margin:0; padding:0; background:none; vertical-align:top;color: #000020;">&nbsp; &nbsp; &nbsp; &nbsp;<span style="color: #000066; font-weight: bold;">for</span> <span style="color: #009900;">&#40;</span><span style="color: #003366; font-weight: bold;">var</span> i<span style="color: #339933;">=</span><span style="color: #CC0000;">0</span><span style="color: #339933;">,</span> il<span style="color: #339933;">=</span>QUEUE.<span style="color: #660066;">clicks</span>.<span style="color: #660066;">length</span><span style="color: #339933;">;</span> i<span style="color: #339933;">&lt;</span>il<span style="color: #339933;">;</span> i<span style="color: #339933;">++</span><span style="color: #009900;">&#41;</span> <span style="color: #009900;">&#123;</span></div></li>
      <li style="font-weight: normal; vertical-align:top;font: normal normal 130% 'Courier New', Courier, monospace; color: #003030;"><div style="font: normal normal 1em/1.2em monospace; margin:0; padding:0; background:none; vertical-align:top;color: #000020;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;$<span style="color: #009900;">&#40;</span>QUEUE.<span style="color: #660066;">clicks</span><span style="color: #009900;">&#91;</span>i<span style="color: #009900;">&#93;</span>.<span style="color: #660066;">target</span><span style="color: #009900;">&#41;</span>.<span style="color: #660066;">click</span><span style="color: #009900;">&#40;</span><span style="color: #009900;">&#41;</span><span style="color: #339933;">;</span></div></li>
      <li style="font-weight: normal; vertical-align:top;font: normal normal 130% 'Courier New', Courier, monospace; color: #003030;"><div style="font: normal normal 1em/1.2em monospace; margin:0; padding:0; background:none; vertical-align:top;color: #000020;">&nbsp; &nbsp; &nbsp; &nbsp;<span style="color: #009900;">&#125;</span></div></li>
      <li style="font-weight: normal; vertical-align:top;font: normal normal 130% 'Courier New', Courier, monospace; color: #003030;"><div style="font: normal normal 1em/1.2em monospace; margin:0; padding:0; background:none; vertical-align:top;color: #000020;">&nbsp; &nbsp; <span style="color: #009900;">&#125;</span><span style="color: #339933;">,</span> <span style="color: #CC0000;">0</span><span style="color: #009900;">&#41;</span><span style="color: #339933;">;</span></div></li>
      <li style="font-weight: normal; vertical-align:top;font: normal normal 130% 'Courier New', Courier, monospace; color: #003030;"><div style="font: normal normal 1em/1.2em monospace; margin:0; padding:0; background:none; vertical-align:top;color: #000020;">&nbsp; <span style="color: #009900;">&#125;</span><span style="color: #009900;">&#41;</span><span style="color: #339933;">;</span></div></li>
      <li style="font-weight: normal; vertical-align:top;font: normal normal 130% 'Courier New', Courier, monospace; color: #003030;"><div style="font: normal normal 1em/1.2em monospace; margin:0; padding:0; background:none; vertical-align:top;color: #000020;"><span style="color: #009900;">&#125;</span><span style="color: #009900;">&#41;</span><span style="color: #009900;">&#40;</span><span style="color: #009900;">&#41;</span><span style="color: #339933;">;</span></div></li>
      </ol></div>
      <p>(This script will need to be loaded as early as possible.)</p>

      <h2>Demo</h2>
      <a href="http://www.example.org">Classic behaviour</a>
      <ul>
        <li>Expected behaviour for a click during the first 5 seconds is to be taken to www.example.org</li>
        <li>Expected behaviour after 5 seconds is an alert with the text "success!"</li>
      </ul>
      
      <a class="guarded" href="http://www.example.org">With the clickcatcher script</a>
      <ul>
        <li>Expected behaviour for a click during the first 5 seconds; delay the click to the fifth second then display an alert with the text "success!"</li>
        <li>Expected behaviour after 5 seconds is an alert with the text "success!"</li>
      </ul>
    </div>
    <script src="/slow-request.js" type="text/javascript" charset="utf-8"></script>
  </body>
</html>

@@script
$(document).ready(function () {
  $('.guarded').click(function() {
    alert("success!");
    return false;
  });
});
