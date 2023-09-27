const app = angular.module("admin_module", ["ngRoute"]);

app.controller("account_controller", account);

app.controller("category_controller", category);

// app.controller("order_controller", order);

app.controller("product_controller", product);

app.controller("role_controller", role);

app.config(function ($routeProvider, $locationProvider) {
    $locationProvider.hashPrefix("");
    $routeProvider

        // account
        .when("/admin/accounts", {
            templateUrl: "/views/account/index.html",
            controller: "account_controller"
        })
        .when("/admin/accounts/add", {
            templateUrl: "/views/account/add.html",
            controller: "account_controller"
        })

        

        // category
        .when("/admin/categories", {
            templateUrl: "/views/category/index.html",
            controller: "category_controller"
        })



        // order
        .when("/admin/orders", {
            templateUrl: "/views/addCategory.html"
        })


        // products
        .when("/admin/products", {
            templateUrl: "/views/product/index.html",
            controller: "product_controller"
        })
        .when("/admin/products/add", {
            templateUrl: "/views/product/add.html",
            controller: "product_controller"
        })


        // role
        .when("/admin/roles", {
            templateUrl: "/views/role/index.html",
            controller: "role_controller"
        })


        .otherwise(
            {
                redirectTo: "/admin"
            });


});