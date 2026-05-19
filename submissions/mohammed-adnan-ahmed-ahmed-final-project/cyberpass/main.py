import sys
import random
import string

from PySide6.QtWidgets import (
    QApplication,
    QWidget,
    QLabel,
    QPushButton,
    QVBoxLayout,
    QHBoxLayout,
    QLineEdit,
    QSpinBox,
    QCheckBox,
    QSizePolicy,
)

from PySide6.QtCore import Qt


class PasswordGenerator(QWidget):
    def __init__(self):
        super().__init__()

        # Window Settings
        self.setWindowTitle("CyberPass Generator")
        self.resize(500, 320)
        self.setMinimumSize(400, 250)

        # ===== TITLE =====
        self.title = QLabel("CyberPass Password Generator")
        self.title.setAlignment(Qt.AlignCenter)

        self.title.setStyleSheet("""
            font-size: 24px;
            font-weight: bold;
            color: #ffffff;
            margin-bottom: 15px;
        """)

        # ===== PASSWORD OUTPUT =====
        self.password_output = QLineEdit()
        self.password_output.setReadOnly(True)
        self.password_output.setPlaceholderText("Generated password will appear here")

        self.password_output.setStyleSheet("""
            QLineEdit {
                padding: 12px;
                font-size: 16px;
                border-radius: 10px;
                background-color: #2b2b2b;
                color: white;
                border: 2px solid #3c3c3c;
            }
        """)

        # ===== PASSWORD LENGTH =====
        self.length_label = QLabel("Password Length:")
        self.length_label.setStyleSheet("""
            color: white;
            font-size: 14px;
        """)

        self.length_input = QSpinBox()
        self.length_input.setRange(4, 64)
        self.length_input.setValue(12)

        self.length_input.setStyleSheet("""
            QSpinBox {
                padding: 6px;
                background-color: #2b2b2b;
                color: white;
                border-radius: 6px;
                border: 1px solid #444;
            }
        """)

        # ===== CHECKBOX =====
        self.symbol_checkbox = QCheckBox("Include Symbols")
        self.symbol_checkbox.setChecked(True)

        self.symbol_checkbox.setStyleSheet("""
            QCheckBox {
                color: white;
                font-size: 14px;
                margin-top: 10px;
            }
        """)

        # ===== BUTTONS =====
        self.generate_button = QPushButton("Generate Password")
        self.copy_button = QPushButton("Copy Password")

        self.generate_button.clicked.connect(self.generate_password)
        self.copy_button.clicked.connect(self.copy_password)

        button_style = """
            QPushButton {
                background-color: #0078d7;
                color: white;
                font-size: 15px;
                font-weight: bold;
                padding: 12px;
                border-radius: 10px;
                border: none;
            }

            QPushButton:hover {
                background-color: #0090ff;
            }

            QPushButton:pressed {
                background-color: #005ea6;
            }
        """

        self.generate_button.setStyleSheet(button_style)
        self.copy_button.setStyleSheet(button_style)

        # Make buttons expand nicely
        self.generate_button.setSizePolicy(
            QSizePolicy.Expanding,
            QSizePolicy.Fixed
        )

        self.copy_button.setSizePolicy(
            QSizePolicy.Expanding,
            QSizePolicy.Fixed
        )

        # ===== PASSWORD STRENGTH =====
        self.strength_label = QLabel("")
        self.strength_label.setAlignment(Qt.AlignCenter)

        self.strength_label.setStyleSheet("""
            font-size: 14px;
            font-weight: bold;
            margin-top: 10px;
        """)

        # ===== LAYOUTS =====
        main_layout = QVBoxLayout()

        main_layout.setContentsMargins(25, 25, 25, 25)
        main_layout.setSpacing(15)

        main_layout.addWidget(self.title)
        main_layout.addWidget(self.password_output)

        length_layout = QHBoxLayout()
        length_layout.addWidget(self.length_label)
        length_layout.addWidget(self.length_input)

        main_layout.addLayout(length_layout)

        main_layout.addWidget(self.symbol_checkbox)
        main_layout.addWidget(self.generate_button)
        main_layout.addWidget(self.copy_button)
        main_layout.addWidget(self.strength_label)

        self.setLayout(main_layout)

        # ===== DARK THEME =====
        self.setStyleSheet("""
            QWidget {
                background-color: #1e1e1e;
                font-family: Arial;
            }
        """)

    # ===== GENERATE PASSWORD =====
    def generate_password(self):
        length = self.length_input.value()

        characters = string.ascii_letters + string.digits

        if self.symbol_checkbox.isChecked():
            characters += string.punctuation

        password = ''.join(random.choice(characters) for _ in range(length))

        self.password_output.setText(password)

        # Password Strength Logic
        if length < 8:
            self.strength_label.setText("Weak Password")
            self.strength_label.setStyleSheet("""
                color: #ff4d4d;
                font-size: 14px;
                font-weight: bold;
            """)

        elif length < 12:
            self.strength_label.setText("Medium Password")
            self.strength_label.setStyleSheet("""
                color: #ffaa00;
                font-size: 14px;
                font-weight: bold;
            """)

        else:
            self.strength_label.setText("Strong Password")
            self.strength_label.setStyleSheet("""
                color: #00ff99;
                font-size: 14px;
                font-weight: bold;
            """)

    # ===== COPY PASSWORD =====
    def copy_password(self):
        clipboard = QApplication.clipboard()
        clipboard.setText(self.password_output.text())

        self.strength_label.setText("Password copied to clipboard")
        self.strength_label.setStyleSheet("""
            color: #00ccff;
            font-size: 14px;
            font-weight: bold;
        """)


# ===== APP START =====
app = QApplication(sys.argv)

window = PasswordGenerator()
window.show()

sys.exit(app.exec())