function product($scope, $http, $location) {
    const productApi = "http://localhost:8080/admin/products";
    const categoryApi = "http://localhost:8080/admin/categories";

    $scope.updateIndex = -1;

    $scope.product = {
        id: "",
        name: "",
        image: "",
        price: 0,
        createDate: "",
        available: true,
        category: ""

    };

    $scope.listProduct = [];

    function clear() {
        $scope.product = {
            id: "",
            name: "",
            image: "",
            price: 0,
            createDate: "",
            available: true,
            category: ""
        };
        $scope.updateIndex = -1;
    }

    $scope.btnUpdateOnClick = function (event, index) {
        event.preventDefault();

        const p = $scope.listProduct[index];
        $scope.product.name = p.name;
        $scope.product.image = p.image;
        $scope.product.price = p.price;
        $scope.product.createDate = p.createDate;
        $scope.product.available = p.available;
        $scope.product.category.id = p.category.id;

        $scope.updateIndex = index;

        $location.path("/admin/products/add");
    }

    $http.get(productApi).then(function (response) {
        $scope.listProduct = response.data;
    }).catch(function (error) {
        // Xử lý lỗi
        console.error('Không thể lấy được dữ liệu: ', error);
        // Hiển thị thông báo cho người dùng
        alert('Không thể lấy được dữ liệu. Vui lòng thử lại sau.');
    });


    function post() {
        $http.post(productApi, $scope.product)
            .then(function (response) {
                $scope.listProduct.push($scope.product);
                clear();
            });
        console.log($scope.product);
    }

    function put() {
        $http.put(productApi + "/" + $scope.listProduct[$scope.updateIndex].id, $scope.product)
            .then(function (response) {
                $scope.listProduct[$scope.updateIndex] = Object.assign({}, $scope.product);
                clear
            });
        console.log($scope.product);
    }

    $scope.save = async function (event) {
        event.preventDefault();
    
        if ($scope.updateIndex == -1) {
            await post();
        } else {
            await put();
        }
        $location.path("/admin/products");
    }
    
    $scope.delete = function (event, index) {
        event.preventDefault();
        event.stopPropagation();

        $http.delete(productApi + "/" + $scope.listProduct[index].id)
            .then(function (response) {
                $scope.listProduct.splice(index, 1);
            });
    }

    $scope.clear = function (event) {
        event.preventDefault();
        clear();
    }

    $scope.listCategory = [];

    $http.get(categoryApi).then(function (response) {
        $scope.listCategory = response.data;
    });

}

