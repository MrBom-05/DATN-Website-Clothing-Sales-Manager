function category($scope, $http) {
    const categoryApi = "http://localhost:8080/admin/categories";

    $scope.updateIndex = -1;

    $scope.category = {
        id: "",
        name: ""
    }

    $scope.listCategory = [];

    function clear() {
        $scope.category = {
            id: "",
            name: ""
        }
    }


    $http.get(categoryApi).then(function (response) {
        $scope.listCategory = response.data;
    }).catch(function (error) {
        // Xử lý lỗi
        console.error('Không thể lấy được dữ liệu: ', error);
        // Hiển thị thông báo cho người dùng
        alert('Không thể lấy được dữ liệu. Vui lòng thử lại sau.');
    });

    function post() {
        $http.post(categoryApi, $scope.category)
            .then(function (response) {
                $scope.listCategory.push($scope.category);
                clear();
            });
        console.log($scope.category);
    }

    $scope.btnUpdateOnClick = function (event, index) {
        event.preventDefault();

        const p = $scope.listCategory[index];
        $scope.category.id = p.id;
        $scope.category.name = p.name;

        $scope.updateIndex = index;
        console.log(p.id);
    }

    function put() {
        $http.put(categoryApi + "/" + $scope.listCategory[$scope.updateIndex].id, $scope.category)
            .then(function (response) {
                $scope.listCategory[$scope.updateIndex] = Object.assign({}, $scope.category);
                clear();
            });
        console.log($scope.category);
    }

    $scope.save = function (event) {
        event.preventDefault();

        if ($scope.updateIndex == -1) {
            post();
        } else {
            put();
        }
    }

    $scope.delete = function (event, index) {
        event.preventDefault();

        $http.delete(categoryApi + "/" + $scope.listCategory[index].id)
            .then(function (response) {
                $scope.listCategory.splice(index, 1);
            });
    }
}