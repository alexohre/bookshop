// document.addEventListener("turbo:load", () => {
// 	const csrfToken = document
// 		.querySelector('meta[name="csrf-token"]')
// 		.getAttribute("content");

// 	const handleAddBook = async (event) => {
// 		if (event.target.classList.contains("add-book")) {
// 			event.preventDefault();
// 			const bookId = event.target.dataset.bookId;

// 			try {
// 				const response = await fetch(`/admin/sales/add_to_pending/${bookId}`, {
// 					method: "POST",
// 					headers: {
// 						"Content-Type": "application/json",
// 						"X-CSRF-Token": csrfToken,
// 						Accept: "text/vnd.turbo-stream.html",
// 					},
// 				});

// 				if (!response.ok) {
// 					throw new Error("Network response was not ok");
// 				}

// 				const turboStream = await response.text();
// 				Turbo.renderStreamMessage(turboStream);
// 			} catch (error) {
// 				console.error("Error:", error);
// 			}
// 		}
// 	};

// 	const handleRemoveBook = async (event) => {
// 		if (event.target.classList.contains("remove-book")) {
// 			event.preventDefault();
// 			const bookId = event.target.dataset.bookId;

// 			try {
// 				const response = await fetch(
// 					`/admin/sales/remove_from_pending/${bookId}`,
// 					{
// 						method: "DELETE",
// 						headers: {
// 							"Content-Type": "application/json",
// 							"X-CSRF-Token": csrfToken,
// 							Accept: "text/vnd.turbo-stream.html",
// 						},
// 					}
// 				);

// 				if (!response.ok) {
// 					throw new Error("Network response was not ok");
// 				}

// 				const turboStream = await response.text();
// 				Turbo.renderStreamMessage(turboStream);
// 			} catch (error) {
// 				console.error("Error:", error);
// 			}
// 		}
// 	};

// 	document.addEventListener("click", handleAddBook);
// 	document.addEventListener("click", handleRemoveBook);
// });
