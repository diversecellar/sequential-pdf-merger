# Sequential PDF Merger - Bulk PDF Processing Application

A powerful and efficient **PDF merging application** built with **Python** and **PowerShell** that allows you to process multiple PDF files in bulk with sequential organization. This application is designed to streamline document management workflows by automatically merging PDFs in a structured, sequential manner.

The app provides both a graphical user interface and automated processing capabilities, making it suitable for both individual users and batch processing scenarios.

The app is coded with the philosophy of "spacing, readability and independence" over "compactness and minimization".

## Purpose and Use Cases

This sequential PDF merger was developed to address common document processing challenges in academic, administrative, and business environments:

### Academic Applications
- **Exam Script Processing**: Merge individual scanned pages into complete documents
- **Assignment Collection**: Combine multiple student submissions into organized batches
- **Research Document Compilation**: Merge related research papers and documentation

### Administrative Use Cases
- **Invoice Processing**: Combine sequential invoices into monthly/quarterly batches
- **Report Compilation**: Merge departmental reports into comprehensive documents
- **Archive Organization**: Sequential processing of historical documents

### Business Applications
- **Contract Management**: Merge contract pages and amendments sequentially
- **Proposal Assembly**: Combine proposal sections into final documents
- **Documentation Processing**: Bulk processing of technical documentation

## Features

### Core Functionality
- **Sequential PDF Merging**: Processes PDFs in alphabetical/numerical order
- **Bulk Processing**: Handle hundreds of PDF files in a single operation
- **Automated Organization**: Creates organized output directories automatically
- **Progress Tracking**: Real-time processing status and completion indicators

### Advanced Features
- **Smart File Detection**: Automatically finds and processes PDF files in directories
- **Output Management**: Creates structured output folders with descriptive names
- **Error Handling**: Robust error handling for corrupted or inaccessible files
- **Performance Optimization**: Fast processing at approximately 0.05 seconds per file

### Technical Features
- **Python-Based Processing**: Uses robust PDF manipulation libraries
- **PowerShell Automation**: Automated build and installation scripts
- **Windows Integration**: Native Windows executable with system integration
- **Virtual Environment Support**: Isolated Python environment for dependency management

## Requirements

### System Requirements
- **Operating System**: Windows 10 or higher
- **PowerShell**: PowerShell 7.5+ (recommended)
- **Python**: Python 3.9+ (automatically installed if not present)
- **Memory**: Minimum 4GB RAM (8GB recommended for large batches)
- **Storage**: Sufficient space for input and output PDF files

### Dependencies
- **PyPDF**: PDF manipulation and merging
- **PyMuPDF**: Advanced PDF processing capabilities
- **Tkinter**: GUI file dialog interface
- **Python Virtual Environment**: Isolated dependency management

## Installation

### Automated Installation (Recommended)

1. **Download and Extract**: Extract the application to your desired directory
2. **Run Installer**: Execute the installer when prompted for administrative privileges

```powershell
# If Windows Python already exists, the app will use it automatically
# If not, click the installer and grant admin privileges when prompted
# Installation takes approximately 3-5 minutes
```

### Manual Installation (Advanced Users)

1. **Open PowerShell**: Navigate to the application directory
2. **Run Build Script**: Execute the macro script

```powershell
# Open PowerShell terminal in the application home directory
powershell.exe .\ps-base\macro.ps1
```

### Installation Process Details

The installation process includes:
- **Python Detection**: Checks for existing Python installation
- **Dependency Installation**: Installs required PDF processing libraries
- **Virtual Environment Setup**: Creates isolated Python environment
- **Executable Generation**: Creates `merger-app.exe` for easy access
- **System Integration**: Configures Windows integration

## Usage

### Quick Start Guide

1. **Launch Application**: Double-click `merger-app.exe` in the program directory
2. **Select Input Directory**: Choose the folder containing your PDF files
3. **Automatic Processing**: The application processes files sequentially
4. **Retrieve Results**: Find merged output in the automatically created subfolder

### Detailed Usage Instructions

#### Step 1: Prepare Your PDF Files
- **Organize Files**: Place all PDF files to be merged in a single directory
- **File Naming**: Ensure files are named in the desired merge order
- **File Verification**: Confirm all files are valid PDF documents

#### Step 2: Run the Application
```
1. Navigate to the program directory
2. Double-click "merger-app.exe"
3. Application launches with file dialog
```

#### Step 3: Select Input Directory
- **Browse**: Use the file dialog to navigate to your PDF directory
- **Example**: If your PDFs are in "Desktop/CIV2011F Scans", select that folder
- **Confirm**: Click OK to begin processing

#### Step 4: Monitor Processing
- **Real-time Updates**: Watch processing progress in the console
- **Performance**: Processing occurs at ~0.05 seconds per file
- **Completion**: Application notifies when processing is complete

#### Step 5: Access Results
- **Output Location**: Results are saved in the same input directory
- **Output Folder**: Look for a subfolder named "[Original Folder Name] - Merged Outputs"
- **Example**: "CIV2011F Scans - Merged Outputs"

### Example Workflow

```
Input Directory: "Desktop/CIV2011F Scans/"
├── page001.pdf
├── page002.pdf
├── page003.pdf
└── page004.pdf

After Processing:
Desktop/CIV2011F Scans/
├── page001.pdf (original files remain)
├── page002.pdf
├── page003.pdf
├── page004.pdf
└── CIV2011F Scans - Merged Outputs/
    └── merged_document.pdf (sequential merge result)
```

## Configuration

### Processing Options
- **Merge Order**: Files are processed in alphabetical/numerical order
- **Output Naming**: Output files use descriptive names based on input directory
- **Directory Structure**: Original files remain unchanged, outputs go to new subfolder

### Performance Settings
- **Processing Speed**: Optimized for ~0.05 seconds per file
- **Memory Usage**: Efficient memory management for large file sets
- **Error Tolerance**: Continues processing if individual files encounter issues

### Advanced Configuration
For advanced users who need custom settings:
- Edit configuration files in the `src/` directory
- Modify processing parameters in the Python scripts
- Adjust output naming conventions in the merger logic

## Troubleshooting

### Common Issues

#### Application Won't Start
- **Solution**: Ensure all dependencies are installed correctly
- **Check**: Verify Python installation and virtual environment
- **Reinstall**: Run the installation process again if needed

#### PDF Processing Errors
- **Corrupted Files**: Check if input PDFs are valid and accessible
- **File Permissions**: Ensure read/write access to input and output directories
- **File Size**: Very large PDFs may require additional processing time

#### Installation Problems
- **Admin Rights**: Ensure you grant administrator privileges during installation
- **Antivirus**: Temporarily disable antivirus if it blocks the installation
- **Disk Space**: Verify sufficient disk space for installation and processing

#### Performance Issues
- **Large Files**: Processing time increases with file size and quantity
- **Memory**: Close other applications if processing large batches
- **Storage**: Ensure sufficient disk space for output files

### Debug Mode
To enable detailed logging for troubleshooting:
1. Open command prompt in the application directory
2. Run: `merger-app.exe --debug`
3. Check log files for detailed error information

### Getting Help
- **Log Files**: Check application logs for detailed error messages
- **System Requirements**: Verify your system meets minimum requirements
- **File Validation**: Ensure input PDF files are not corrupted

## Development and Customization

### Project Structure
```
sequential-pdf-merger/
├── src/                    # Python source code
│   ├── merger.py          # Core PDF merging logic
│   └── main.py            # Application entry point
├── ps-base/               # PowerShell scripts
│   ├── macro.ps1          # Build automation
│   ├── installer.ps1      # Installation script
│   └── uninstaller.ps1    # Removal script
├── README.md              # This documentation
└── merger-app.exe         # Compiled application
```

### Customization Options
- **Merge Logic**: Modify PDF merging algorithms in `src/merger.py`
- **UI Improvements**: Enhance file dialog and user interface
- **Output Formatting**: Customize output file naming and organization
- **Performance Tuning**: Adjust processing parameters for specific use cases

### Building from Source
```powershell
# Clone or download the source code
# Navigate to the project directory
# Run the build script
powershell.exe .\ps-base\macro.ps1
```

## Technical Details

### PDF Processing Engine
- **Library**: PyPDF and PyMuPDF for robust PDF handling
- **Merge Algorithm**: Sequential page-by-page merging
- **Memory Management**: Efficient processing of large PDF sets
- **Error Recovery**: Graceful handling of corrupted or inaccessible files

### Performance Characteristics
- **Processing Speed**: ~0.05 seconds per file
- **Memory Usage**: Optimized for minimal memory footprint
- **Scalability**: Handles hundreds of files in single batch
- **Error Rate**: Robust error handling for various PDF formats

### Security and Privacy
- **Local Processing**: All PDF processing occurs locally on your machine
- **No Network Access**: Application doesn't require internet connection
- **File Privacy**: Original files remain unchanged and private
- **Data Security**: No data is transmitted or stored externally

## Updates and Maintenance

### Version Management
- **Automatic Updates**: Check for updates periodically
- **Dependency Updates**: Keep PDF processing libraries current
- **Security Patches**: Apply Windows and Python security updates

### Backup Recommendations
- **Original Files**: Always maintain backups of original PDF files
- **Output Archives**: Consider archiving processed results
- **Application Backup**: Keep a copy of the application installer

## Support and Feedback

### Getting Support
- **Documentation**: Refer to this comprehensive guide first
- **Troubleshooting**: Follow the troubleshooting section for common issues
- **Log Analysis**: Check application logs for detailed error information

### Providing Feedback
- **Bug Reports**: Document any issues with detailed error messages
- **Feature Requests**: Suggest improvements or new functionality
- **Performance Feedback**: Report processing times and system performance

## License and Disclaimer

This application is provided for legitimate document processing purposes. Users are responsible for:
- **Copyright Compliance**: Ensuring proper rights to process and merge PDF documents
- **Data Security**: Maintaining security of processed documents
- **Legal Compliance**: Following applicable laws and regulations regarding document processing

## Best Practices

### File Organization
- **Consistent Naming**: Use consistent file naming conventions
- **Logical Ordering**: Name files to reflect desired merge sequence
- **Directory Structure**: Keep related files in dedicated directories

### Processing Workflow
- **Test Runs**: Test with small batches before processing large sets
- **Backup Strategy**: Always backup original files before processing
- **Quality Check**: Verify merged outputs meet your requirements

### Performance Optimization
- **Batch Size**: Process files in manageable batches for very large sets
- **System Resources**: Close unnecessary applications during processing
- **Storage Management**: Ensure sufficient disk space for outputs

---

**Remember**: This tool is designed for efficient, sequential PDF merging with a focus on reliability and ease of use. Always maintain backups of your original documents and verify processing results meet your requirements.