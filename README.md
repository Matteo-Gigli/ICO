# ICO


<h2>💡 ICO (Initial Coin Offering) </h2>
<br>

<p><strong>I just created an ICO.</strong></p>
<br>

<h2>🔍 Contracts Detail</h2>
<br>


<h3>💰 ICOToken.sol</h3>
<br>
<p><strong>Simple Erc20 Token where we are going to override some functions.</strong></p>
<p><strong>To use this contract, we must to pass only one parameter and it's totalSupply for our new Token.</strong></p>
<p><strong>We will able to buy this token in the ICOExchange contract.</strong></p>

<br>

<h3>📊 ICOExchange.sol</h3>
<br>

<p><strong>This is the contract to manage all.</strong></p>
<p><strong>Functions to start with are: </strong></p>
<p><strong>initIcoToken and the initIcoNft (passing IcoToken address and IcoNft address).</strong></p>

<br>
<p><strong>As we can see from the contract, now we have some functions.</strong></p> 

<br>

<p><strong>buyIcoTokens(uint amount)</strong></p>
<p><strong>We can buy some tokens with this function.</strong></p>
<p><strong>Amount can't exceed total supply and should be > 0.</strong></p>
<p><strong>Price per token is 0.001 ether, so if we are going to buy 100 we will pay 0.1 ether.</strong></p>
<p><strong>With this function we have a NFT Free Mint.</strong></p>
<p><strong>This NFT will be used to claim some 10 more tokens once.</strong></p>
<p><strong>NFT Token Ids start from 0.</strong></p>


<br>
<p><strong>claimEth()</strong></p>
<p><strong>With this function, only the owner of the contract, can withdraw ethers from the contract.</strong></p>



<h3>🗿 ICONft.sol</h3>
<br>
<p><strong>This is a simple contract for our custom ERC721</strong></p>
<br>
