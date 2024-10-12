using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FSK.Service.Services.Systems
{
    public class FengShuiService
    {
        public int CalculateFengShui(DateTime birthday, string gender)
        {
            // Lấy năm sinh
            int year = birthday.Year;

            // Tính Thiên Can
            int canValue = GetThienCanValue(year);

            // Tính Địa Chi
            int chiValue = GetDiaChiValue(year);

            // Tổng của Thiên Can và Địa Chi để tính Ngũ hành
            int sum = canValue + chiValue;

            // Trừ đi 5 nếu tổng lớn hơn 5
            if (sum > 5) sum -= 5;

            // Lấy Ngũ Hành
            //string element = GetNguHanh(sum);

            // test thử các giá trị có đúng không
            //nhập 09-21-2004 
            //expected value: Thiên Can: 1, Địa Chi: 1, Ngũ Hành: 2 (thủy)
            //string result = $"Thiên Can: {canValue}, Địa Chi: {chiValue}, Ngũ Hành: {element}";

            // Trả về kết quả
            return sum;
        }

        private int GetThienCanValue(int year)
        {
            //Tính thiên can: lấy chữ số cuối cùng của năm sinh (bằng cách lấy phần dư khi chia năm sinh cho 10) 
            int lastDigit = year % 10;
            return lastDigit switch
            {
                //Quy ước thiên can để tính ngũ hành: lấy số cuối năm sinh so với dưới đây để lấy điểm:
                4 => 1, // Giáp
                5 => 1, // Ất
                6 => 2, // Bính
                7 => 2, // Đinh
                8 => 3, // Mậu
                9 => 3, // Kỷ
                0 => 4, // Canh
                1 => 4, // Tân
                2 => 5, // Nhâm
                3 => 5, // Quý
                _ => throw new ArgumentException("Invalid input"),
            };
        }

        private int GetDiaChiValue(int year)
        {
            //Tính địa chi: lấy phần dư khi chia năm sinh với 12 
            int remainder = year % 12;
            return remainder switch
            {
                //Quy ước địa chi để tính ngũ hành: lấy phần dư khi chia năm sinh với 12 so với dưới đây để lấy điểm:
                0 => 1, // Thân
                1 => 1, // Dậu
                2 => 2, // Tuất
                3 => 2, // Hợi
                4 => 0, // Tý
                5 => 0, // Sửu
                6 => 1, // Dần
                7 => 1, // Mão
                8 => 2, // Thìn
                9 => 2, // Tỵ
                10 => 0, // Ngọ
                11 => 0, // Mùi
                _ => throw new ArgumentException("Invalid input"),
            };
        }

        //private string GetNguHanh(int value)
        //{
        //    return value switch
        //    {
        //        1 => "Kim",
        //        2 => "Thủy",
        //        3 => "Hỏa",
        //        4 => "Thổ",
        //        5 => "Mộc",
        //        _ => throw new ArgumentException("Invalid input"),
        //    };
        //}

        public int CalculateCungPhi(DateTime birthday, string gender)
        {
            int year = birthday.Year;

            int lastTwoDigits = year % 100;

            // Step 1: Calculate the sum of the last two digits
            int sum = SumDigits(lastTwoDigits);
            //sum = SumDigits(sum); // If sum > 9, sum the digits again

            // If born before 2000
            if (year < 2000)
            {
                if (gender.ToLower() == "male")
                {
                    int b = 10 - sum;
                    //return GetCungPhi(b, gender);
                    return b;
                }
                else
                {

                    int c = 5 + sum;
                    //return GetCungPhi(c, gender);
                    return SumDigits(c);
                }
            }
            // If born after or in 2000
            else
            {
                if (gender.ToLower() == "male")
                {
                    int b = 9 - sum;
                    //return GetCungPhi(b, gender);
                    return b;
                }
                else
                {
                    int c = 6 + sum;
                    //return GetCungPhi(c, gender);
                    return SumDigits(c); ;
                }
            }
        }

        // Helper method to sum digits until the result is a single digit
        private int SumDigits(int number)
        {
            while (number > 9)
            {
                number = number / 10 + number % 10;
            }
            return number;
        }

        // Method to determine Cung Phi based on the final value
        private string GetCungPhi(int value, string gender)
        {
            return value switch
            {
                0 => gender.ToLower() == "male" ? "Ly" : "Invalid value",
                1 => "Khảm",
                2 => "Khôn",
                3 => "Chấn",
                4 => "Tốn",
                5 => gender.ToLower() == "male" ? "Khôn" : "Cấn",
                6 => "Càn",
                7 => "Đoài",
                8 => "Cấn",
                9 => "Ly",
                _ => "Invalid value"
            };
        }
    }




}
