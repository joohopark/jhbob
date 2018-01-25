
하샤드수
입력 값의 각 자리수를 더해서 나눴을때 떨어지면 하샤드 수임.
구하는 함수 구현.

    func harshad(input : Int){
        var index = 1
    
        while (input/10*index) > 1 {
            index += 1
        }
    
        if input % index == 0{
            print("\(input)은 하샤드수 입니다.")
        }else{
            print("\(input)은 하샤드수가 아닙니다.")
        }
    
    }
