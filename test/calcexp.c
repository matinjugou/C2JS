#include <stdio.h>
#include <string.h>

int main()
{
    char buf[512];
    int buf_iter;
    int buf_len;
    char c;

    char opr_stack[256];
    int stack_end;
    int output[256];
    int output_end;

    stack_end = 0;
    output_end = 0;

    gets(buf);

    buf_iter = 0;
    buf_len = strlen(buf);

    while (buf_iter != buf_len)
    {
        c = buf[buf_iter];

        if (c >= '0' && c <= '9')
        {
            int num;
            num = c - '0';

            buf_iter = buf_iter + 1;
            while (buf_iter != buf_len && buf[buf_iter] >= '0' && buf[buf_iter] <= '9')
            {
                num = num * 10;
                num = num + (buf[buf_iter] - '0');
                buf_iter = buf_iter + 1;
            }

            output[output_end] = num;
            output_end = output_end + 1;
            buf_iter = buf_iter - 1;
        }
        else if (c == '(')
        {
            opr_stack[stack_end] = c;
            stack_end = stack_end + 1;
        }
        else if (c == ')')
        {
            while (opr_stack[stack_end - 1] != '(')
            {
                if (opr_stack[stack_end - 1] == '*')
                    output[output_end - 2] = output[output_end - 2] * output[output_end - 1];
                else if (opr_stack[stack_end - 1] == '/')
                    output[output_end - 2] = output[output_end - 2] / output[output_end - 1];
                else if (opr_stack[stack_end - 1] == '+')
                    output[output_end - 2] = output[output_end - 2] + output[output_end - 1];
                else if (opr_stack[stack_end - 1] == '-')
                    output[output_end - 2] = output[output_end - 2] - output[output_end - 1];
                output_end = output_end - 1;
                stack_end = stack_end - 1;
            }
            stack_end = stack_end - 1;
        }
        else if (c == ' ')
        {
        }
        else
        {
            if (stack_end > 0 && opr_stack[stack_end - 1] != '(' && (c == '+' || c == '-') || (opr_stack[stack_end - 1] == '*' && opr_stack[stack_end - 1] == '/'))
            {
                if (opr_stack[stack_end - 1] == '*')
                    output[output_end - 2] = output[output_end - 2] * output[output_end - 1];
                else if (opr_stack[stack_end - 1] == '/')
                    output[output_end - 2] = output[output_end - 2] / output[output_end - 1];
                else if (opr_stack[stack_end - 1] == '+')
                    output[output_end - 2] = output[output_end - 2] + output[output_end - 1];
                else if (opr_stack[stack_end - 1] == '-')
                    output[output_end - 2] = output[output_end - 2] - output[output_end - 1];
                output_end = output_end - 1;
                stack_end = stack_end - 1;
            }
            opr_stack[stack_end] = c;
            stack_end = stack_end + 1;
        }

        buf_iter = buf_iter + 1;
    }

    while (stack_end > 0)
    {
        if (opr_stack[stack_end - 1] == '*')
            output[output_end - 2] = output[output_end - 2] * output[output_end - 1];
        else if (opr_stack[stack_end - 1] == '/')
            output[output_end - 2] = output[output_end - 2] / output[output_end - 1];
        else if (opr_stack[stack_end - 1] == '+')
            output[output_end - 2] = output[output_end - 2] + output[output_end - 1];
        else if (opr_stack[stack_end - 1] == '-')
            output[output_end - 2] = output[output_end - 2] - output[output_end - 1];
        output_end = output_end - 1;
        stack_end = stack_end - 1;
    }

    printf("%d", output[0]);

    return 0;
}
