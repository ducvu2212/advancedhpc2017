#include <stdio.h>
#include <include/labwork.h>
#include <cuda_runtime_api.h>
#include <omp.h>

#define ACTIVE_THREADS 4

int main(int argc, char **argv) {
    printf("USTH ICT Master 2017, Advanced Programming for HPC.\n");
    if (argc < 2) {
        printf("Usage: labwork <lwNum> <inputImage>\n");
        printf("   lwNum        labwork number\n");
        printf("   inputImage   the input file name, in JPEG format\n");
        return 0;
    }

    int lwNum = atoi(argv[1]);
    std::string inputFilename;

    // pre-initialize CUDA to avoid incorrect profiling
    printf("Warming up...\n");
    char *temp;
    cudaMalloc(&temp, 1024);

    Labwork labwork;
    if (lwNum != 2 ) {
        inputFilename = std::string(argv[2]);
        labwork.loadInputImage(inputFilename);
    }

    printf("Starting labwork %d\n", lwNum);
    Timer timer;
    timer.start();
    switch (lwNum) {
        case 1:
            labwork.labwork1_CPU();
            labwork.saveOutputImage("labwork2-cpu-out.jpg");
            printf("labwork 1 CPU ellapsed %.1fms\n", lwNum, timer.getElapsedTimeInMilliSec());
            timer.start();
            labwork.labwork1_OpenMP();
            labwork.saveOutputImage("labwork2-openmp-out.jpg");
            break;
        case 2:
            labwork.labwork2_GPU();
            break;
        case 3:
            labwork.labwork3_GPU();
            labwork.saveOutputImage("labwork3-gpu-out.jpg");
            break;
        case 4:
            labwork.labwork4_GPU();
            labwork.saveOutputImage("labwork4-gpu-out.jpg");
            break;
        case 5:
            labwork.labwork5_CPU();
            labwork.saveOutputImage("labwork5-cpu-out.jpg");
            labwork.labwork5_GPU();
            labwork.saveOutputImage("labwork5-gpu-out.jpg");
            break;
        case 6:
            labwork.labwork6_GPU();
            labwork.saveOutputImage("labwork6-gpu-out.jpg");
            break;
        case 7:
            labwork.labwork7_GPU();
            labwork.saveOutputImage("labwork7-gpu-out.jpg");
            break;
        case 8:
            labwork.labwork8_GPU();
            labwork.saveOutputImage("labwork8-gpu-out.jpg");
            break;
        case 9:
            labwork.labwork9_GPU();
            labwork.saveOutputImage("labwork9-gpu-out.jpg");
            break;
        case 10:
            labwork.labwork10_GPU();
            labwork.saveOutputImage("labwork10-gpu-out.jpg");
            break;
    }
    printf("labwork %d ellapsed %.1fms\n", lwNum, timer.getElapsedTimeInMilliSec());
}

void Labwork::loadInputImage(std::string inputFileName) {
    inputImage = jpegLoader.load(inputFileName);
}

void Labwork::saveOutputImage(std::string outputFileName) {
    jpegLoader.save(outputFileName, outputImage, inputImage->width, inputImage->height, 90);
}

void Labwork::labwork1_CPU() {
    int pixelCount = inputImage->width * inputImage->height;
    outputImage = static_cast<char *>(malloc(pixelCount * 3));
    for (int j = 0; j < 100; j++) {		// let's do it 100 times, otherwise it's too fast!
        for (int i = 0; i < pixelCount; i++) {
            outputImage[i * 3] = (char) (((int) inputImage->buffer[i * 3] + (int) inputImage->buffer[i * 3 + 1] +
                                          (int) inputImage->buffer[i * 3 + 2]) / 3);
            outputImage[i * 3 + 1] = outputImage[i * 3];
            outputImage[i * 3 + 2] = outputImage[i * 3];
        }
    }
}

void Labwork::labwork1_OpenMP() {
    int pixelCount = inputImage->width * inputImage->height;
    outputImage = static_cast<char *>(malloc(pixelCount * 3));
    #pragma omp parallel for
    for (int j = 0; j < 100; j++) {             // let's do it 100 times, otherwise it's too fast!    
    for (int i = 0; i < pixelCount; i++) {
            outputImage[i * 3] = (char) (((int) inputImage->buffer[i * 3] + (int) inputImage->buffer[i * 3 + 1] +
                                          (int) inputImage->buffer[i * 3 + 2]) / 3);
            outputImage[i * 3 + 1] = outputImage[i * 3];
            outputImage[i * 3 + 2] = outputImage[i * 3];
        }
    }

}

int getSPcores(cudaDeviceProp devProp) {
    int cores = 0;
    int mp = devProp.multiProcessorCount;
    switch (devProp.major) {
        case 2: // Fermi
            if (devProp.minor == 1) cores = mp * 48;
            else cores = mp * 32;
            break;
        case 3: // Kepler
            cores = mp * 192;
            break;
        case 5: // Maxwell
            cores = mp * 128;
            break;
        case 6: // Pascal
            if (devProp.minor == 1) cores = mp * 128;
            else if (devProp.minor == 0) cores = mp * 64;
            else printf("Unknown device type\n");
            break;
        default:
            printf("Unknown device type\n");
            break;
    }
    return cores;
}

void Labwork::labwork2_GPU() {
    int deviceNum;
    cudaGetDeviceCount(&deviceNum);
    printf ("The number of devices: %d\n",deviceNum);
    for (int i = 0; i < deviceNum; i++) {
	cudaDeviceProp prop;
	cudaGetDeviceProperties(&prop, i);
	printf("Device Number: %d\n", i);
	printf("Device Name: %s\n", prop.name);
	printf("Memory Clock Rate: %d\n", prop.memoryClockRate);
	printf("Memory Bus Width: %d\n", prop.memoryBusWidth);
	printf("Memory Bandwidth: %f\n\n", 2.0*prop.memoryClockRate*(prop.memoryBusWidth/8)/1.0e6);
    }
}

__global__ void grayscale(uchar3 *input, uchar3 *output) {
int tid = threadIdx.x + blockIdx.x * blockDim.x;
output[tid].x = (input[tid].x + input[tid].y +
input[tid].z) / 3;
output[tid].z = output[tid].y = output[tid].x;
}

void Labwork::labwork3_GPU() {
    int pixelCount = inputImage->width * inputImage->height;
    int blockSize = 64;
    int numBlock = pixelCount / blockSize;
    outputImage = static_cast<char *>(malloc(pixelCount * 3));
    uchar3 *devInput, *devOutput;

    cudaMalloc(&devInput, pixelCount * 3 * sizeof(char));
    cudaMalloc(&devOutput, pixelCount * 3 * sizeof(char));
    cudaMemcpy(devInput, inputImage->buffer, pixelCount * 3 * sizeof(char), cudaMemcpyHostToDevice);

    
    grayscale<<<numBlock, blockSize>>>(devInput, devOutput);
    
    cudaMemcpy(outputImage, devOutput, pixelCount * 3 * sizeof(char),  cudaMemcpyDeviceToHost);
    
    cudaFree(devInput);
    cudaFree(devOutput);   
}

__global__ void grayscale2d(uchar3 *input, uchar3 *outputGrey, int width) {
int x = threadIdx.x + blockIdx.x * blockDim.x;
int y = threadIdx.y + blockIdx.y * blockDim.y;
int tid = y * width + x;
outputGrey[tid].x = (input[tid].x + input[tid].y + input[tid].z) / 3;
outputGrey[tid].z = outputGrey[tid].y = outputGrey[tid].x;
}


void Labwork::labwork4_GPU() {
    int pixelCount = inputImage->width * inputImage->height;
    dim3 gridSize = dim3(8, 8);
    dim3 blockSize = dim3(32, 32);
    outputImage = static_cast<char *>(malloc(pixelCount * 3));

    uchar3 *devInput, *devOutputGrey;

    cudaMalloc(&devInput, pixelCount * 3 * sizeof(char));
    cudaMalloc(&devOutputGrey, pixelCount * 3 * sizeof(char));
    cudaMemcpy(devInput, inputImage->buffer, pixelCount * 3 * sizeof(char), cudaMemcpyHostToDevice);


    grayscale2d<<<gridSize, blockSize>>>(devInput, devOutputGrey, inputImage->width);

    cudaMemcpy(outputImage, devOutputGrey, pixelCount * 3 * sizeof(char),  cudaMemcpyDeviceToHost);

    cudaFree(devInput);
    cudaFree(devOutputGrey);
}



__global__ void blur2d(uchar3 *outputGrey, uchar3 *output, int width, int height) {
	    
            int kernel[] = { 0, 0, 1, 2, 1, 0, 0,
                     0, 3, 13, 22, 13, 3, 0,
                     1, 13, 59, 97, 59, 13, 1,
                     2, 22, 97, 159, 97, 22, 2,
                     1, 13, 59, 97, 59, 13, 1,
                     0, 3, 13, 22, 13, 3, 0,
                     0, 0, 1, 2, 1, 0, 0 };

	    int pixelCount = width * height;
            int sum = 0;
            int c = 0;
	    int col = threadIdx.x + blockIdx.x * blockDim.x;
            int row = threadIdx.y + blockIdx.y * blockDim.y;
            for (int y = -3; y <= 3; y++) {
                for (int x = -3; x <= 3; x++) {
                    int i = col + x;
                    int j = row + y;
                    if (i < 0) continue;
                    if (i >= width) continue;
                    if (j < 0) continue;
                    if (j >= height) continue;
                    int tid = j * width + i;
                    unsigned char gray = outputGrey[tid].x;
                    int coefficient = kernel[(y+3) * 7 + x + 3];
                    sum = sum + gray * coefficient;
                    c += coefficient;
                }
            }
            sum /= 1003;
            int posOut = row * width + col;
            output[posOut].x = output[posOut].y = output[posOut].z = sum;
}


// CPU implementation of Gaussian Blur
void Labwork::labwork5_CPU() {
    int kernel[] = { 0, 0, 1, 2, 1, 0, 0,  
                     0, 3, 13, 22, 13, 3, 0,  
                     1, 13, 59, 97, 59, 13, 1,  
                     2, 22, 97, 159, 97, 22, 2,  
                     1, 13, 59, 97, 59, 13, 1,  
                     0, 3, 13, 22, 13, 3, 0,
                     0, 0, 1, 2, 1, 0, 0 };
    int pixelCount = inputImage->width * inputImage->height;
    outputImage = (char*) malloc(pixelCount * sizeof(char) * 3);
    for (int row = 0; row < inputImage->height; row++) {
        for (int col = 0; col < inputImage->width; col++) {
            int sum = 0;
            int c = 0;
            for (int y = -3; y <= 3; y++) {
                for (int x = -3; x <= 3; x++) {
                    int i = col + x;
                    int j = row + y;
                    if (i < 0) continue;
                    if (i >= inputImage->width) continue;
                    if (j < 0) continue;
                    if (j >= inputImage->height) continue;
                    int tid = j * inputImage->width + i;
                    unsigned char gray = (inputImage->buffer[tid * 3] + inputImage->buffer[tid * 3 + 1] + inputImage->buffer[tid * 3 + 2])/3;
                    int coefficient = kernel[(y+3) * 7 + x + 3];
                    sum = sum + gray * coefficient;
                    c += coefficient;
                }
            }
            sum /= c;
            int posOut = row * inputImage->width + col;
            outputImage[posOut * 3] = outputImage[posOut * 3 + 1] = outputImage[posOut * 3 + 2] = sum;
        }
    }
}

void Labwork::labwork5_GPU() {
    int pixelCount = inputImage->width * inputImage->height;
    dim3 blockSize = dim3(32, 32);
    dim3 gridSize = dim3(inputImage->width/blockSize.x, inputImage->height/blockSize.y);
    outputImage = static_cast<char *>(malloc(pixelCount * 3));

    uchar3 *devInput, *devOutputGrey, *devOutput;

    cudaMalloc(&devInput, pixelCount * 3 * sizeof(char));
    cudaMalloc(&devOutputGrey, pixelCount * 3 * sizeof(char));
    cudaMalloc(&devOutput, pixelCount * 3 * sizeof(char));
    cudaMemcpy(devInput, inputImage->buffer, pixelCount * 3 * sizeof(char), cudaMemcpyHostToDevice);


    grayscale2d<<<gridSize, blockSize>>>(devInput, devOutputGrey, inputImage->width);
    blur2d<<<gridSize, blockSize>>>(devOutputGrey, devOutput, inputImage->width, inputImage->height); 

    cudaMemcpy(outputImage, devOutput, pixelCount * 3 * sizeof(char),  cudaMemcpyDeviceToHost);

    cudaFree(devInput);
    cudaFree(devOutputGrey);
    cudaFree(devOutput);
}


__global__ void grayscaleBinary(uchar3 *input, uchar3 *outputGrey, int width) {
	int x = threadIdx.x + blockIdx.x * blockDim.x;
	int y = threadIdx.y + blockIdx.y * blockDim.y;
	int tid = y * width + x;
	unsigned char grey = (input[tid].x + input[tid].y + input[tid].z) / 3;
	if (grey >= 180) { outputGrey[tid].x = outputGrey[tid].y = outputGrey[tid].z = 255; }
	else { outputGrey[tid].x = outputGrey[tid].y = outputGrey[tid].z = 0; }
}


void Labwork::labwork6_GPU() {
    int pixelCount = inputImage->width * inputImage->height;
    dim3 blockSize = dim3(32, 32);
    dim3 gridSize = dim3(inputImage->width/blockSize.x, inputImage->height/blockSize.y);
    outputImage = static_cast<char *>(malloc(pixelCount * 3));

    uchar3 *devInput, *devOutputGrey;

    cudaMalloc(&devInput, pixelCount * 3 * sizeof(char));
    cudaMalloc(&devOutputGrey, pixelCount * 3 * sizeof(char));
    cudaMemcpy(devInput, inputImage->buffer, pixelCount * 3 * sizeof(char), cudaMemcpyHostToDevice);


    grayscaleBinary<<<gridSize, blockSize>>>(devInput, devOutputGrey, inputImage->width);

    cudaMemcpy(outputImage, devOutputGrey, pixelCount * 3 * sizeof(char),  cudaMemcpyDeviceToHost);

    cudaFree(devInput);
    cudaFree(devOutputGrey);

}

void Labwork::labwork7_GPU() {

}

void Labwork::labwork8_GPU() {

}

void Labwork::labwork9_GPU() {

}

void Labwork::labwork10_GPU() {

}

