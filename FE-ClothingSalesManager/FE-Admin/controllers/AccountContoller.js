function account($scope, $http, $location) {
    const accountApi = "http://localhost:8080/admin/accounts";
    const roleApi = "http://localhost:8080/admin/roles";

    $scope.updateIndex = -1;

    $scope.account = {
        username: "",
        fullname: "",
        email: "",
        password: "",
        photo: "",
        role: []
    }

    $scope.listAccount = [];

    function clear() {
        // $scope.role = {
        //     id: "",
        //     name: ""
        // }
    }

    $scope.selectedRoles = [];
    $scope.updateSelectedRoles = function (role) {
        if (role.selected) {
            $scope.selectedRoles.push(role.id);
        } else {
            const index = $scope.selectedRoles.indexOf(role.id);
            if (index !== -1) {
                $scope.selectedRoles.splice(index, 1);
            }
        }
        // Gán giá trị các role đã chọn vào thuộc tính role của đối tượng account
        $scope.account.role = $scope.selectedRoles;
    };


    $scope.btnUpdateOnClick = function (event, index) {
        event.preventDefault();


        const p = $scope.listAccount[index];
        $scope.account.username = p.username;
        $scope.account.fullname = p.fullname;
        $scope.account.email = p.email;



        $scope.updateIndex = index;
        console.log(p);

        $location.path("/admin/accounts/add");
    }

    $http.get(accountApi).then(function (response) {
        $scope.listAccount = response.data;
    }).catch(function (error) {
        // Xử lý lỗi
        console.error('Không thể lấy được dữ liệu: ', error);
        // Hiển thị thông báo cho người dùng
        alert('Không thể lấy được dữ liệu. Vui lòng thử lại sau.');
    });

    function post() { 
        $http.post(accountApi, $scope.account)
            .then(function (response) {
                $scope.listAccount.push($scope.account);
                clear();
            });
        console.log($scope.account);
    }

    function put() {
        $http.put(accountApi + "/" + $scope.listAccount[$scope.updateIndex].username, $scope.account)
            .then(function (response) {
                $scope.listAccount[$scope.updateIndex] = Object.assign({}, $scope.account);
                clear();
            });
        console.log($scope.account);
    }

    $scope.save = async function (event) {
    event.preventDefault();

        if ($scope.updateIndex == -1) {
            await post();
        } else {
            await put();
        }
        $location.path("/admin/accounts");
    }

    $scope.delete = function (event, index) {
        event.preventDefault();
        event.stopPropagation();
        $http.delete(accountApi + "/" + $scope.listAccount[index].username)
            .then(function (response) {
                $scope.listAccount.splice(index, 1);
            });
    }

    $scope.listRole = [];

    $http.get(roleApi).then(function (response) {
        $scope.listRole = response.data;
    });
}