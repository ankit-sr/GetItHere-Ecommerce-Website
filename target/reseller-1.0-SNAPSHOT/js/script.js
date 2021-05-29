function addtocart(pid, pname, price)
{
    let cart = localStorage.getItem("cart");
    if (cart == null)
    {
        //No cart yet
        let products = [];
        let product = {productId: pid, productName: pname, productQuantity: 1, productPrice: price};
        products.push(product);
        localStorage.setItem("cart", JSON.stringify(products));
//                console.log("Product added to the cart!!")
        showToast("Item is added to the Cart !!")

    } else {
        //cart is alreadt present
        let pcart = JSON.parse(cart);
        let oldProduct = pcart.find((item) => item.productId == pid);
        if (oldProduct)
        {
            //increase product quantity
            oldProduct.productQuantity = oldProduct.productQuantity + 1;
            pcart.map((item) => {
                if (item.productId == oldProduct.productId)
                {
                    item.productQuantity = oldProduct.productQuantity;
                }
            })
            localStorage.setItem("cart", JSON.stringify(pcart));
            //               console.log("Product quantity increased!!")
            showToast(oldProduct.productName + " Quantity is Increased !!")

        } else {
            //Add new product
            let product = {productId: pid, productName: pname, productQuantity: 1, productPrice: price};
            pcart.push(product);
            localStorage.setItem("cart", JSON.stringify(pcart));
//              console.log("Item is added to the cart!!")
            showToast("Item is added to the cart !!")

        }
    }

    update_cart();
}

function update_cart()
{
    let cartString = localStorage.getItem("cart");
    let cart = JSON.parse(cartString);
    if (cart == null || cart.length == 0)
    {
        console.log("Cart is empty!!")
        $(".cart-items").html("(0)");
        $(".cart-body").html("<h3>Cart is empty!! Add items to start shopping.</h3>");
        $(".checkout-btn").attr('disabled',true);
    } else
    {
        console.log(cart)
        $(".cart-items").html(`( ${cart.length} )`);
        let table = `
        
        <table class='table'>
        <thead class='thread-light'>
        <tr>
        <th>Item Name</th>
        <th>Price</th>
        <th>Quantity</th>
        <th>Total Price</th>
        <th>Action</th>
        
            
        </tr>
        </thead>

        `;
        let totalPrice = 0;
        cart.map((item) => {
            table += `
            <tr>
            <td> ${item.productName} </td>
            <td> ${item.productPrice} </td>
            <td> ${item.productQuantity}</td>
            <td> ${item.productQuantity * item.productPrice} </td>
            <td> <button onclick='removeItem(${item.productId})' class='btn btn-danger'>Remove</button> </td>
            </tr>
            `
            totalPrice += item.productPrice * item.productQuantity;
        })


        table = table + `    
        <tr><td colspan='5' class="text-right font-weight-bold"> Total Price : ${totalPrice}</td></tr>        
        </table>`
        $(".cart-body").html(table);
        $(".checkout-btn").attr('disabled',false);
    }

}

// Remove item from cart
function removeItem(pid)
{
    let cart = JSON.parse(localStorage.getItem('cart'));
    let newcart = cart.filter((item) => item.productId != pid)
    localStorage.setItem('cart', JSON.stringify(newcart))
    update_cart();
    showToast("Item is removed from cart !!")
}

$(document).ready(function () {
    update_cart()
})


function showToast(content) {
    $("#toast").addClass("display");
    $("#toast").html(content);
    setTimeout(() => {
        $("#toast").removeClass("display");
    }, 2000);
}

function goToCheckout() 
{
    window.location = "checkout.jsp"
}

